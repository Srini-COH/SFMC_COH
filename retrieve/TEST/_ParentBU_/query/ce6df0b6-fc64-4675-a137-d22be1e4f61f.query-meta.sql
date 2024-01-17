SELECT DISTINCT
    ObjOpportunity.Id AS Id,
    Facility.Name AS SelectedFacility,
    ObjOpportunity.AccountId AS ContactId,
    ObjOpportunity.StageName AS Stage,
    ObjOpportunity.Email__c AS Email,
    ObjOpportunity.Cancer_Type__c AS CancerType,
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
    ObjOpportunity.Nurture_Last_Sent__c AS NurtureLastSent,
    ObjOpportunity.First_Diagnosis_Date__c AS FirstDiagonosisDate,
    ObjOpportunity.Re_occurence_Diagnosis_Date__c AS ReoccurenceDiagnosisDate,
    ObjOpportunity.Previous_Treatment_Type__c AS PreviousTreatmentType,
    ObjOpportunity.Cancer_Stage__c AS CancerStage,
    ObjOpportunity.Nurture_Message_Counter__c AS MessageCounter,
    ObjOpportunity.Nurture_Tile1_Counter__c AS Tile1Counter,
    ObjOpportunity.Nurture_Tile2_Counter__c AS Tile2Counter,
    ObjOpportunity.Nurture_Tile3_Counter__c AS Tile3Counter,
    ObjOpportunity.Name AS Name,
    AllSubscribers.Status AS SubscriptionStatus,
    ObjOpportunity.Owner_First_Name__c AS OwnerFirstName,
    ObjOpportunity.Owner_Last_Name__c AS OwnerLastName,
    ObjOpportunity.Owner_Email__c AS OwnerEmail,
    ObjOpportunity.Owner_Phone__c AS OwnerPhone,
    ObjOpportunity.Purpose_of_call__c AS PurposeOfCall,
    ObjOpportunity.Insurance_Status__c AS InsuranceStatus,
    ObjOpportunity.Topics_Sent__c AS TopicsSent,
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
    LEFT JOIN [_ListSubscribers] AllSubscribers ON ObjOpportunity.AccountId = AllSubscribers.SubscriberKey
    INNER JOIN [Facilities__c_Salesforce] Facility ON (
        ObjOpportunity.Selected_Facility__c = Facility.Id
        AND Facility.Facility_Type__c = 'Inpatient'
    )
WHERE
    (
        (
            ObjOpportunity.Cancer_Type__c NOT IN (
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
        AND (
            ObjOpportunity.Name NOT LIKE '%unk%'
            OR ObjOpportunity.Name NOT LIKE '%delete%'
        )
        AND (
            ObjOpportunity.Cancer_Status__c IN ('Yes', 'Reoccurance - Confirmed')
        )
        AND (
            ObjOpportunity.ECOG__c NOT IN ('In Hospice', 'Not able to perform activities')
        )
        AND (
            ObjOpportunity.CreatedDate >= DATEADD(YEAR, -2, GETDATE())
        )
        AND ObjOpportunity.Owner_Profile_Name__c IN ('NPES', 'Patient Advocate', 'Facilitator')
        AND (
            ObjOpportunity.Last_Contacted_Date__c >= DATEADD(YEAR, -1, GETDATE())
        )
        AND (
            ObjOpportunity.Re_occurence_Diagnosis_Date__c IS NULL
        )
        AND (
            ObjOpportunity.First_Diagnosis_Date__c IS NULL
            OR ObjOpportunity.First_Diagnosis_Date__c >= DATEADD(MONTH, -6, GETDATE())
        )
        AND (
            (ObjOpportunity.Previous_Treatment_Type__c IS NULL)
            OR ObjOpportunity.Previous_Treatment_Type__c IN ('None', 'Unknown')
        )
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
            ObjOpportunity.Insurance_Status__c = 'Full IV Approved'
        )
    )
