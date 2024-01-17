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
    ObjOpportunity.Nurture_Last_Sent__c AS NurtureLastSent,
    ObjOpportunity.First_Diagnosis_Date__c AS FirstDiagnosisDate,
    ObjOpportunity.Re_occurence_Diagnosis_Date__c AS ReoccurenceDiagnosisDate,
    ObjOpportunity.Previous_Treatment_Type__c AS PreviousTreatmentType,
    ObjOpportunity.Cancer_Stage__c AS CancerStage,
    /* No longer used:
    ObjOpportunity.Nurture_Message_Counter__c as MessageCounter,
    ObjOpportunity.Nurture_Tile1_Counter__c as Tile1Counter,
    ObjOpportunity.Nurture_Tile2_Counter__c as Tile2Counter,
    ObjOpportunity.Nurture_Tile3_Counter__c as Tile3Counter,
    ObjOpportunity.Direct_Mailable__c as DirectMailable,
    ObjOpportunity.Owner_Address__c as OwnerAddress,
    (SELECT Count(Name) FROM Resource_Request__c_Salesforce WHERE (ObjOpportunity.Id = Opportunity__c AND Resource_Type__c='Physician Prospect Call Program')) as PhoneaDoc
    */
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
    Contacts.FirstName AS FirstName,
    Contacts.ctca_gender__c AS Gender,
    ObjOpportunity.Segment_Tag_Terms__c AS SegmentTagTerms,
    ObjOpportunity.Insurance_Category__c AS InsuranceCategory,
    ObjOpportunity.Insurance_Submitted_Date__c AS InsuranceSubmittedDate,
    ObjOpportunity.CFCN_Offered__c AS CFCNOfferStatus,
    ObjOpportunity.CFCN_Offered_Date__c AS CFCNOfferDate,
    ObjOpportunity.COH_Referral__c AS CoHReferral
FROM
    [Opportunity_Salesforce] ObjOpportunity
    LEFT JOIN [_ListSubscribers] AllSubscribers ON (
        ObjOpportunity.ContactId__c = AllSubscribers.SubscriberKey
        AND AllSubscribers.ListID = 24
    )
    LEFT JOIN [Facilities__c_Salesforce] Facility ON (ObjOpportunity.Selected_Facility__c = Facility.Id)
    INNER JOIN [Contact_Salesforce] Contacts ON ObjOpportunity.ContactId__c = Contacts.Id
    LEFT JOIN Account_Salesforce Account ON Contacts.AccountId = Account.Id
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
        AND (ObjOpportunity.Name NOT LIKE '%unk%')
        AND (ObjOpportunity.Name NOT LIKE '%delete%')
        AND (
            ObjOpportunity.Cancer_Status__c IN ('Yes', 'Reoccurance - Confirmed')
        )
        AND (
            ObjOpportunity.ECOG__c NOT IN (
                'In Hospice',
                'Not able to perform activities',
                'In Hospice/Poor ECOG',
                'In Hospital/Critical Care',
                'Primary Site Transplant'
            )
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
            'Advocate Manager',
            'Empowerment Manager',
            'Virtual Service Advocate',
            'Government Service Center'
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
                    (
                        ObjOpportunity.Id = Facility_Visits__c_Salesforce.Opportunity__c
                        AND Facility_Visits__c_Salesforce.ctca_apptstatus__c NOT IN ('Return to OIS', 'Appt Entry Error')
                    )
            ) = 0
        )
        AND (
            ObjOpportunity.Purpose_of_call__c IS NULL
            OR ObjOpportunity.Purpose_of_call__c NOT IN ('Non-Oncology')
        )
        AND (
            ObjOpportunity.Intake_Type__c IS NULL
            OR ObjOpportunity.Intake_Type__c = 'Oncology'
        )
        AND (Contacts.Pediatric__c NOT LIKE '1')
        AND (
            ObjOpportunity.Insurance_Status__c IN ('Rapid Approved', 'Full IV Approved')
        )
        AND (ObjOpportunity.Email__c IS NOT NULL)
        AND (ObjOpportunity.Email__c NOT LIKE '%@dmctca.com%')
        AND (
            (Facility.Name IS NULL)
            OR (Facility.Name IN ('MRMC', 'SERMC', 'WRMC'))
        )
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
        /*removed the government exclusion 5/24/22)*/
        /*AND (ObjOpportunity.Insurance_Category__c NOT LIKE '%3%')*/
        /*GSC request that only their last 6 months qualify*/
        AND (
            (
                (
                    ObjOpportunity.Insurance_Category__c NOT LIKE '%3%'
                )
                AND (
                    ObjOpportunity.CreatedDate >= DATEADD(YEAR, -1, GETDATE())
                )
            )
            OR (
                (ObjOpportunity.Insurance_Category__c LIKE '%3%')
                AND ObjOpportunity.CreatedDate >= DATEADD(DAY, -180, GETDATE())
            )
        )
        AND (
            ObjOpportunity.COH_Referral__c IS NULL
            OR ObjOpportunity.COH_Referral__c != 'Offered/Accepted'
        )
        AND (
            ObjOpportunity.RecordTypeId = '0121C000001RL6JQAW'
        )
        AND (ObjOpportunity.Contact_Status__c IS NULL)
        AND (
            Contacts.ctca_newstage__c NOT IN ('Expired', 'Hospice')
        )
        AND (Account.Expired__c NOT LIKE '1')
        AND (Contacts.HealthCloudGA__DeceasedDate__c IS NULL)
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
            Contacts.donotbulkpostalmail__c IS NULL
            OR Contacts.donotbulkpostalmail__c != 'Do not Allow'
        )
        AND (
            Contacts.Nurture_Status__c IS NULL
            OR Contacts.Nurture_Status__c != 'Declined'
        )
        AND (Contacts.HasOptedOutOfEmail NOT LIKE '1')
        AND (
            AllSubscribers.Status IS NULL
            OR AllSubscribers.Status = 'Active'
        )
        AND (
            ObjOpportunity.Owner_Email__c NOT IN (
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
            (ObjOpportunity.Nurture_Last_Sent__c IS NULL)
            OR (
                ObjOpportunity.Nurture_Last_Sent__c <= DATEADD(DAY, -3, GETDATE())
            )
        )
        /*AND (NurtureLog.ContentExhaustedDate IS NULL)*/
    )
