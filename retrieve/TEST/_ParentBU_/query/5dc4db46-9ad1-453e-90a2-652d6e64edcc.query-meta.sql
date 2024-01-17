SELECT DISTINCT
    ObjOpportunity.Id AS Id,
    Facility.Name AS SelectedFacility,
    ObjOpportunity.ContactId__c AS ContactId,
    ObjOpportunity.StageName AS Stage,
    ObjOpportunity.Last_Stage__c AS LastStage,
    ObjOpportunity.Email__c AS Email,
    ObjOpportunity.Primary_Segment__c AS Persona,
    ObjOpportunity.Cancer_Type__c AS CancerType,
    CancerMapping.CancerGrouping AS CancerGroup,
    ObjOpportunity.Cancer_Status__c AS CancerStatus,
    ObjOpportunity.Lead_Score__c AS LeadScore,
    ObjOpportunity.LastActivityDate AS LastActivityDate,
    ObjOpportunity.CreatedDate AS CreatedDate,
    ObjOpportunity.ECOG__c AS ECOG,
    ObjOpportunity.Owner_Profile_Name__c AS OwnerProfileName,
    ObjOpportunity.Nurture_Preference__c AS NurturePreference,
    ObjOpportunity.Nurture_Status__c AS NurtureStatus,
    ObjOpportunity.Last_Contacted_Date__c AS LastContactDate,
    ObjOpportunity.Direct_Mailable__c AS DirectMailable,
    ObjOpportunity.Owner_Address__c AS OwnerAddress,
    ObjOpportunity.Nurture_Last_Sent__c AS NurtureLastSent,
    ObjOpportunity.First_Diagnosis_Date__c AS FirstDiagnosisDate,
    ObjOpportunity.Re_occurence_Diagnosis_Date__c AS ReoccurenceDiagnosisDate,
    ObjOpportunity.Previous_Treatment_Type__c AS PreviousTreatmentType,
    ObjOpportunity.Cancer_Stage__c AS CancerStage,
    ObjOpportunity.Nurture_Message_Counter__c AS MessageCounter,
    ObjOpportunity.Nurture_Tile1_Counter__c AS Tile1Counter,
    ObjOpportunity.Nurture_Tile2_Counter__c AS Tile2Counter,
    ObjOpportunity.Nurture_Tile3_Counter__c AS Tile3Counter,
    ObjOpportunity.Name AS Name,
    Contacts.HasOptedOutOfEmail AS HasOptedOutOfEmail,
    AllSubscribers.Status AS SubscriptionStatus,
    ObjOpportunity.Contact_Status__c AS ContactStatus,
    ObjOpportunity.Owner_First_Name__c AS OwnerFirstName,
    ObjOpportunity.Owner_Last_Name__c AS OwnerLastName,
    ObjOpportunity.Owner_Email__c AS OwnerEmail,
    ObjOpportunity.Owner_Phone__c AS OwnerPhone,
    ObjOpportunity.Purpose_of_call__c AS PurposeOfCall,
    ObjOpportunity.Insurance_Status__c AS InsuranceStatus,
    ObjOpportunity.Topics_Sent__c AS TopicsSent,
    ObjOpportunity.Lead_First_Name__c AS FirstName,
    ObjOpportunity.Segment_Tag_Terms__c AS SegmentTagTerms,
    ObjOpportunity.Insurance_Category__c AS InsuranceCategory,
    ObjOpportunity.Insurance_Submitted_Date__c AS InsuranceSubmittedDate,
    ObjOpportunity.CFCN_Offered__c AS CFCNOfferStatus,
    ObjOpportunity.CFCN_Offered_Date__c AS CFCNOfferDate,
    (
        SELECT
            COUNT(Name)
        FROM
            Resource_Request__c_Salesforce
        WHERE
            (
                ObjOpportunity.Id = Opportunity__c
                AND Resource_Type__c = 'Physician Prospect Call Program'
            )
    ) AS PhoneaDoc
FROM
    [Opportunity_Salesforce] ObjOpportunity
    LEFT JOIN [_ListSubscribers] AllSubscribers ON ObjOpportunity.ContactId__c = AllSubscribers.SubscriberKey
    INNER JOIN [Facilities__c_Salesforce] Facility ON (ObjOpportunity.Selected_Facility__c = Facility.Id)
    INNER JOIN [Contact_Salesforce] Contacts ON ObjOpportunity.ContactId__c = Contacts.Id
    LEFT JOIN [Cancer_Type_Mapping_DE_Journey] CancerMapping ON (
        ObjOpportunity.Cancer_Type__c = CancerMapping.CancerType
    )
    LEFT JOIN [InsApprovedJourneyDE_LOG] NurtureLog ON (
        ObjOpportunity.ContactId__c = NurtureLog.ContactId
    )
WHERE
    (
        (
            ObjOpportunity.Cancer_Type__c NOT IN ('Non-Oncology', 'No diagnosis', 'Benign Growth')
        )
        AND (
            ObjOpportunity.Cancer_Type__c NOT LIKE '%Undiagnosed%'
        )
        AND (
            ObjOpportunity.Cancer_Type__c NOT LIKE '%Screening%'
        )
        AND (
            (ObjOpportunity.Nurture_Preference__c IS NULL)
            OR (
                ObjOpportunity.Nurture_Preference__c NOT IN ('Declined')
            )
        )
        AND (
            (ObjOpportunity.Nurture_Status__c IS NULL)
            OR (
                ObjOpportunity.Nurture_Status__c NOT IN ('Declined')
            )
        )
        AND (ObjOpportunity.Name NOT LIKE '%unk%')
        AND (ObjOpportunity.Name NOT LIKE '%delete%')
        AND (
            ObjOpportunity.Cancer_Status__c IN ('Yes', 'Reoccurance - Confirmed')
        )
        AND (
            ObjOpportunity.ECOG__c NOT IN ('In Hospice', 'Not able to perform activities')
        )
        AND (
            ObjOpportunity.CreatedDate >= DATEADD(YEAR, -1, GETDATE())
        )
        AND (
            ObjOpportunity.CreatedDate <= DATEADD(DAY, -8, GETDATE())
        )
        /*     AND (
        CAST(ObjOpportunity.CreatedDate AS Date) >= '2018-08-29')*/
        AND (
            Contacts.CreatedDate >= DATEADD(YEAR, -1, GETDATE())
        )
        AND ObjOpportunity.Owner_Profile_Name__c IN (
            'NPES',
            'Patient Advocate',
            'Facilitator',
            'Super Advocate Pilot',
            'Advocate Manager'
        )
        /*( AND (
        ObjOpportunity.Last_Contacted_Date__c >= DATEADD(year, -1, GETDATE())
        )
        AND (ObjOpportunity.Re_occurence_Diagnosis_Date__c IS NULL)
        AND (
        ObjOpportunity.First_Diagnosis_Date__c IS NULL
        OR ObjOpportunity.First_Diagnosis_Date__c >= DATEADD(month, -12, GETDATE())
        )
        AND ((ObjOpportunity.Previous_Treatment_Type__c IS NULL) OR ObjOpportunity.Previous_Treatment_Type__c IN ('None', 'Unknown'))*/
        AND (
            (
                SELECT
                    COUNT(Id)
                FROM
                    Facility_Visits__c_Salesforce
                WHERE
                    ObjOpportunity.Id = Facility_Visits__c_Salesforce.Opportunity__c
            ) = 0
        )
        AND (
            ObjOpportunity.Purpose_of_call__c IS NULL
            OR ObjOpportunity.Purpose_of_call__c NOT IN ('Non-Oncology')
        )
        AND (
            ObjOpportunity.Insurance_Status__c IN ('Rapid Approved', 'Full IV Approved')
        )
        AND (ObjOpportunity.Email__c IS NOT NULL)
        AND (ObjOpportunity.Email__c NOT LIKE '%@dmctca.com%')
        AND Facility.Name LIKE '%RMC%'
        AND (ObjOpportunity.Cancer_Type__c IS NOT NULL)
        AND (ObjOpportunity.Lead_Score__c > (10))
        AND (
            ObjOpportunity.StageName IN ('Insurance Approved')
            OR (
                (
                    ObjOpportunity.StageName IN ('Inactive')
                    AND (
                        ObjOpportunity.Last_Stage__c IN ('Insurance Approved')
                    )
                )
            )
        )
        AND (
            ObjOpportunity.Insurance_Category__c NOT LIKE '%7%'
        )
        AND (
            ObjOpportunity.Insurance_Category__c NOT LIKE '%3%'
        )
        AND (ObjOpportunity.Contact_Status__c IS NULL)
        AND (Contacts.HasOptedOutOfEmail NOT LIKE '1')
        AND (NurtureLog.ContentExhaustedDate IS NULL)
    )
