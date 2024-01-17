SELECT DISTINCT
    ObjLead.Id AS LeadID,
    ObjLead.Selected_Facility__c AS SelectedFacility,
    ObjLead.Status AS Status,
    ObjLead.Last_Status__c AS LastStatus,
    ObjLead.Primary_Segment__c AS Persona,
    ObjLead.Email AS Email,
    ObjLead.Cancer_Type__c AS CancerType,
    /*   CancerMapping.CancerGrouping as CancerGroup,*/
    ObjLead.Cancer_Status__c AS CancerStatus,
    ObjLead.Lead_Score__c AS LeadScore,
    ObjLead.Topics_Sent__c AS TopicsSent,
    ObjLead.LastActivityDate AS LastActivityDate,
    ObjLead.CreatedDate AS CreatedDate,
    ObjLead.ECOG__c AS ECOG,
    ObjLead.Insurance_Category__c AS InsuranceCategory,
    ObjLead.Purpose_of_Call__c AS PurposeOfCall,
    ObjLead.Owner_Profile_Name__c AS OwnerProfileName,
    ObjLead.Nurture_Preference__c AS NurturePreference,
    ObjLead.HasOptedOutOfEmail AS HasOptedOutOfEmail,
    ObjLead.Contact_Status__c AS ContactStatus,
    ObjLead.Nurture_Status__c AS NurtureStatus,
    ObjLead.Last_Contacted_Date__c AS LastContactDate,
    ObjLead.Direct_Mailable__c AS DirectMailable,
    ObjLead.Nurture_Last_Sent__c AS NurtureLastSent,
    ObjLead.Nurture_Message_Counter__c AS MessageCounter,
    ObjLead.Nurture_Tile1_Counter__c AS Tile1Counter,
    ObjLead.Nurture_Tile2_Counter__c AS Tile2Counter,
    ObjLead.Nurture_Tile3_Counter__c AS Tile3Counter,
    ObjLead.First_Diagnosis_Date__c AS FirstDiagnosisDate,
    ObjLead.Re_occurence_Diagnosis_Date__c AS ReoccurenceDiagnosisDate,
    ObjLead.Previous_Treatment_Type__c AS PreviousTreatmentType,
    ObjLead.Cancer_Stage__c AS CancerStage,
    ObjLead.Segment_Tag_Terms__c AS SegmentTagTerms,
    ObjLead.FirstName AS FirstName,
    ObjLead.Owner_First_Name__c AS OwnerFirstName,
    ObjLead.Owner_Last_Name__c AS OwnerLastName,
    ObjLead.Owner_Email__c AS OwnerEmail,
    ObjLead.Owner_Phone__c AS OwnerPhone,
    ObjLead.Owner_Address__c AS OwnerAddress,
    AllSubscribers.Status AS SubscriptionStatus,
    (
        SELECT
            CancerGrouping
        FROM
            Cancer_Type_Mapping_DE_Journey
        WHERE
            ObjLead.Cancer_Type__c = CancerType
    ) AS CancerGroup,
    (
        SELECT
            COUNT(Name)
        FROM
            Resource_Request__c_Salesforce
        WHERE
            (
                ObjLead.Id = Lead__c
                AND Resource_Type__c = 'Physician Prospect Call Program'
            )
    ) AS PhoneaDoc
FROM
    [Lead_Salesforce] ObjLead
    LEFT JOIN [_ListSubscribers] AllSubscribers ON ObjLead.Id = AllSubscribers.SubscriberKey
    LEFT JOIN [Facilities__c_Salesforce] Facility ON (ObjLead.Selected_Facility__c = Facility.Id)
    LEFT JOIN [Cancer_Type_Mapping_DE_Journey] CancerMapping ON (ObjLead.Cancer_Type__c = CancerMapping.CancerType)
WHERE
    (
        (ObjLead.Email IS NOT NULL)
        AND (ObjLead.Email NOT LIKE '%@dmctca.com%')
        AND ObjLead.Status IN ('Prospective', 'Referred')
        AND (
            ObjLead.Cancer_Type__c NOT IN ('Non-Oncology', 'No diagnosis', 'Benign Growth')
        )
        AND (ObjLead.Cancer_Type__c NOT LIKE '%Undiagnosed%')
        AND (ObjLead.Cancer_Type__c NOT LIKE '%Screening%')
        AND (
            (ObjLead.Nurture_Preference__c IS NULL)
            OR (ObjLead.Nurture_Preference__c NOT IN ('Declined'))
        )
        AND (
            (ObjLead.Nurture_Status__c IS NULL)
            OR (ObjLead.Nurture_Status__c NOT IN ('Declined'))
        )
        AND (ObjLead.FirstName NOT LIKE '%unk%')
        AND (ObjLead.FirstName NOT LIKE '%delete%')
        AND (
            ObjLead.Cancer_Status__c IN ('Yes', 'Reoccurance - Confirmed')
        )
        AND (
            ObjLead.ECOG__c NOT IN ('In Hospice', 'Not able to perform activities')
        )
        AND (
            ObjLead.CreatedDate >= DATEADD(YEAR, -1, GETDATE())
        )
        AND (
            ObjLead.CreatedDate <= DATEADD(DAY, -8, GETDATE())
        )
        AND ObjLead.Owner_Profile_Name__c IN (
            'NPES',
            'Patient Advocate',
            'Facilitator',
            'Super Advocate Pilot',
            'Advocate Manager'
        )
        /*    AND (ObjLead.Re_occurence_Diagnosis_Date__c IS NULL)
        AND (
        ObjLead.First_Diagnosis_Date__c IS NULL
        OR ObjLead.First_Diagnosis_Date__c >= DATEADD(month, -6, GETDATE())
        )
        AND ((ObjLead.Previous_Treatment_Type__c IS NULL) OR ObjLead.Previous_Treatment_Type__c IN ('None', 'Unknown'))
        */
        AND (
            ObjLead.Purpose_of_call__c IS NULL
            OR ObjLead.Purpose_of_call__c NOT IN ('Non-Oncology')
        )
        AND Facility.Name LIKE '%RMC%'
        AND (ObjLead.Lead_Score__c > (10))
    )
