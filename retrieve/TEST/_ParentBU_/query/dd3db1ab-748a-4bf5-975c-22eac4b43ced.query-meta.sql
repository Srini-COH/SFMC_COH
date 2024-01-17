SELECT DISTINCT
    ObjLead.Id AS LeadID,
    Facility.Name AS SelectedFacility,
    ObjLead.Status AS Status,
    ObjLead.Primary_Segment__c AS Persona,
    ObjLead.Email AS Email,
    ObjLead.Cancer_Type__c AS CancerType,
    ObjLead.Cancer_Status__c AS CancerStatus,
    ObjLead.Lead_Score__c AS LeadScore,
    ObjLead.Topics_Sent__c AS TopicsSent,
    ObjLead.LastActivityDate AS LastActivityDate,
    ObjLead.CreatedDate AS CreatedDate,
    ObjLead.ECOG__c AS ECOG,
    ObjLead.Owner_Profile_Name__c AS OwnerProfileName,
    ObjLead.Nurture_Preference__c AS NurturePreference,
    ObjLead.Nurture_Status__c AS NurtureStatus,
    ObjLead.Last_Contacted_Date__c AS LastContactDate,
    ObjLead.Direct_Mailable__c AS DirectMailable,
    ObjLead.Nurture_Last_Sent__c AS NurtureLastSent,
    ObjLead.First_Diagnosis_Date__c AS FirstDiagonosisDate,
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
    INNER JOIN [Facilities__c_Salesforce] Facility ON (
        ObjLead.Selected_Facility__c = Facility.Id
        AND Facility.Facility_Type__c = 'Inpatient'
    )
WHERE
    (
        (ObjLead.Email IS NOT NULL)
        AND ObjLead.Status IN ('Prospect', 'Referred')
        AND (
            ObjLead.Cancer_Type__c NOT IN (
                'Undiagnosed',
                'Undiagnosed - Lung',
                'Non-Oncology',
                'No diagnosis',
                'Screening - Breast',
                'Screening - Colon/Rectal',
                'Screening - Lung',
                'Screening - Prostate',
                'Undiagnosed - Breast',
                'Undiagnosed - Breast-Inflammatory',
                'Undiagnosed - Liver-Metastasis',
                'Undiagnosed - Liver-Primary',
                'Undiagnosed - Ovarian',
                'Undiagnosed - Pancreatic',
                'Undiagnosed - Suspicion',
                'Undiagnosed - To See Doctor for Biopsy',
                'Undiagnosed - Waiting for Test Results',
                'Undiagnosed - Waiting on Biopsy',
                'Benign Growth'
            )
        )
        AND (
            (ObjLead.Nurture_Preference__c IS NULL)
            OR (ObjLead.Nurture_Preference__c NOT IN ('Declined'))
        )
        AND (
            (ObjLead.Nurture_Status__c IS NULL)
            OR (ObjLead.Nurture_Status__c NOT IN ('Declined'))
        )
        AND (
            ObjLead.FirstName NOT LIKE '%unk%'
            OR ObjLead.FirstName NOT LIKE '%delete%'
        )
        AND (
            ObjLead.Cancer_Status__c IN ('Yes', 'Reoccurance - Confirmed')
        )
        AND (
            ObjLead.ECOG__c NOT IN ('In Hospice', 'Not able to perform activities')
        )
        AND (
            ObjLead.CreatedDate >= DATEADD(YEAR, -2, GETDATE())
        )
        AND ObjLead.Owner_Profile_Name__c IN ('Patient Advocate', 'NPES', 'Facilitator')
        AND (
            ObjLead.Last_Contacted_Date__c >= DATEADD(YEAR, -1, GETDATE())
        )
        /*AND (ObjLead.Re_occurence_Diagnosis_Date__c IS NULL)
        AND (
        ObjLead.First_Diagnosis_Date__c IS NULL
        OR ObjLead.First_Diagnosis_Date__c >= DATEADD(month, -6, GETDATE())
        )
        AND ((ObjLead.Previous_Treatment_Type__c IS NULL) OR ObjLead.Previous_Treatment_Type__c IN ('None', 'Unknown')
        )*/
    )
