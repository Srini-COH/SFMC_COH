SELECT DISTINCT
    ObjLead.Id AS LeadID,
    Facility.Name AS SelectedFacility,
    ObjLead.Status AS Status,
    ObjLead.Last_Status__c AS LastStatus,
    ObjLead.Primary_Segment__c AS Persona,
    ObjLead.Email AS Email,
    ObjLead.Cancer_Type__c AS CancerType,
    ObjLead.Cancer_Status__c AS CancerStatus,
    ObjLead.Lead_Score__c AS LeadScore,
    ObjLead.Topics_Sent__c AS TopicsSent,
    ObjLead.LastActivityDate AS LastActivityDate,
    ObjLead.CreatedDate AS CreatedDate,
    ObjLead.ECOG__c AS ECOG,
    ObjLead.Insurance_Category__c AS InsuranceCategory,
    ObjLead.Purpose_of_call__c AS PurposeOfCall,
    ObjLead.Owner_Profile_Name__c AS OwnerProfileName,
    ObjLead.HasOptedOutOfEmail AS HasOptedOutOfEmail,
    ObjLead.Contact_Status__c AS ContactStatus,
    ObjLead.Nurture_Preference__c AS NurturePreference,
    ObjLead.Nurture_Status__c AS NurtureStatus,
    ObjLead.Last_Contacted_Date__c AS LastContactDate,
    ObjLead.Direct_Mailable__c AS DirectMailable,
    ObjLead.Nurture_Last_Sent__c AS NurtureLastSent,
    /*Not needed:
    ObjLead.Nurture_Message_Counter__c as MessageCounter,
    ObjLead.Nurture_Tile1_Counter__c as Tile1Counter,
    ObjLead.Nurture_Tile2_Counter__c as Tile2Counter,
    ObjLead.Nurture_Tile3_Counter__c as Tile3Counter,
    ObjLead.Segment_Tag_Terms__c as SegmentTagTerms,
    ObjLead.Owner_Address__c as OwnerAddress,*/
    ObjLead.First_Diagnosis_Date__c AS FirstDiagnosisDate,
    ObjLead.Re_occurence_Diagnosis_Date__c AS ReoccurenceDiagnosisDate,
    ObjLead.Previous_Treatment_Type__c AS PreviousTreatmentType,
    ObjLead.Cancer_Stage__c AS CancerStage,
    ObjLead.FirstName AS FirstName,
    ObjLead.Owner_First_Name__c AS OwnerFirstName,
    ObjLead.Owner_Last_Name__c AS OwnerLastName,
    ObjLead.Owner_Email__c AS OwnerEmail,
    ObjLead.Owner_Phone__c AS OwnerPhone,
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
    ) AS PhoneaDoc,
    ObjLead.IsConverted AS Converted,
    ObjLead.COH_Referral__c AS CoHReferral,
    ObjLead.RecordTypeId AS RecordType,
    ObjLead.Cancer_Journey_Segments__c AS CancerJourneySegment
FROM
    [Lead_Salesforce] ObjLead
    LEFT JOIN [_ListSubscribers] AllSubscribers ON (
        ObjLead.Id = AllSubscribers.SubscriberKey
        AND AllSubscribers.ListID = 24
    )
    LEFT JOIN [Facilities__c_Salesforce] Facility ON (ObjLead.Selected_Facility__c = Facility.Id)
    LEFT JOIN [Cancer_Type_Mapping_DE_Journey] CancerMapping ON (ObjLead.Cancer_Type__c = CancerMapping.CancerType)
WHERE
    (
        (ObjLead.Email IS NOT NULL)
        AND (ObjLead.Email NOT LIKE '%@dmctca.com%')
        AND (
            (
                ObjLead.Status IN ('Prospect', 'Prospective', 'Referred')
            )
            OR (
                (ObjLead.Status IN ('Inactive'))
                AND (
                    ObjLead.Last_Status__c IN ('Prospect', 'Prospective', 'Referred')
                )
            )
        )
        AND (ObjLead.IsConverted NOT LIKE '1')
        AND (
            ObjLead.Cancer_Type__c NOT IN ('Non-Oncology', 'No diagnosis', 'Benign Growth')
        )
        AND (ObjLead.Cancer_Type__c NOT LIKE '%Undiagnosed%')
        AND (ObjLead.Cancer_Type__c NOT LIKE '%Screening%')
        AND (ObjLead.Cancer_Type__c NOT LIKE '%Non-Oncology%')
        AND (ObjLead.Cancer_Type__c IS NOT NULL)
        AND (
            (ObjLead.Nurture_Preference__c IS NULL)
            OR (ObjLead.Nurture_Preference__c NOT IN ('Declined'))
        )
        AND (
            (ObjLead.Nurture_Status__c IS NULL)
            OR (ObjLead.Nurture_Status__c NOT IN ('Declined'))
        )
        AND (
            (ObjLead.FirstName IS NULL)
            OR (
                (ObjLead.FirstName NOT LIKE '%unk%')
                AND (ObjLead.FirstName NOT LIKE '%delete%')
            )
        )
        AND (
            ObjLead.Cancer_Status__c IN ('Yes', 'Reoccurance - Confirmed')
        )
        AND (
            ObjLead.ECOG__c NOT IN (
                'In Hospice',
                'Not able to perform activities',
                'In Hospice/Poor ECOG',
                'In Hospital/Critical Care',
                'Primary Site Transplant'
            )
        )
        AND (
            ObjLead.CreatedDate >= DATEADD(YEAR, -1, GETDATE())
        )
        AND (
            ObjLead.CreatedDate <= DATEADD(DAY, -7, GETDATE())
        )
        AND ObjLead.Owner_Profile_Name__c IN (
            'NPES',
            'Patient Advocate',
            'Facilitator',
            'Super Advocate Pilot',
            'Advocate Manager',
            'Facilitator Manager',
            'Empowerment Manager',
            'Virtual Service Advocate' /*,'Government Service Center'*/
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
        AND (
            ObjLead.Intake_Type__c IS NULL
            OR ObjLead.Intake_Type__c = 'Oncology'
        )
        AND (
            (ObjLead.Pediatric__c IS NULL)
            OR (ObjLead.Pediatric__c NOT LIKE '1')
        )
        AND (
            (Facility.Name IS NULL)
            OR (Facility.Name IN ('MRMC', 'SERMC', 'WRMC'))
        )
        AND (ObjLead.Lead_Score__c > (10))
        AND (
            (ObjLead.Insurance_Category__c IS NULL)
            OR (
                (ObjLead.Insurance_Category__c NOT LIKE '%7%')
                AND (ObjLead.Insurance_Category__c NOT LIKE '%3%')
            )
        )
        AND (ObjLead.Contact_Status__c IS NULL)
        AND (ObjLead.HasOptedOutOfEmail NOT LIKE '1')
        AND (
            (ObjLead.Insurance_Type__c IS NULL)
            OR (
                ObjLead.Insurance_Type__c NOT IN ('No insurance – Self Pay Declined')
            )
        )
        AND (
            ObjLead.COH_Referral__c IS NULL
            OR ObjLead.COH_Referral__c != 'Offered/Accepted'
        )
        AND (ObjLead.RecordTypeId = '0121C000001RL6FQAW')
        AND (
            ObjLead.Owner_Email__c NOT IN (
                'brian.shannon@ctca-hope.com',
                'cherie.fiedler@ctca-hope.com',
                'karen.rivera@ctca-hope.com',
                'kathleen.oates@ctca-hope.com',
                'lorena.hurtadoseverino@ctca-hope.com',
                'matt.owen@ctca-hope.com',
                'matthew.steuart@ctca-hope.com',
                'phyllis.weldon@ctca-hope.com'
            )
        )
        AND (
            (ObjLead.Nurture_Last_Sent__c IS NULL)
            OR (
                ObjLead.Nurture_Last_Sent__c <= DATEADD(DAY, -2, GETDATE())
            )
        )
        AND (
            (ObjLead.Topics_Sent__c LIKE '%ToolsTx%')
            OR (
                ObjLead.Topics_Sent__c LIKE '%ToolsAndTreatments%'
            )
        )
    )
