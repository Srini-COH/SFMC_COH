SELECT DISTINCT
    ObjOpportunity.Id AS OpportunityId,
    ObjOpportunity.Name AS Name,
    ObjOpportunity.Lead_First_Name__c AS FirstName,
    ObjOpportunity.Lead__C AS LeadId,
    ObjOpportunity.ContactId__c AS ContactId,
    ObjOpportunity.StageName AS Stage,
    ObjOpportunity.Last_Stage__c AS LastStage,
    ObjOpportunity.Email__c AS Email,
    Facility.Name AS SelectedFacility,
    ObjOpportunity.Primary_Segment__c AS Persona,
    ObjOpportunity.Segment_Tag_Terms__c AS SegmentTagTerms,
    ObjOpportunity.Cancer_Type__c AS CancerType,
    CancerMapping.CancerGrouping AS CancerGroup,
    ObjOpportunity.Lead_Score__c AS LeadScore,
    ObjOpportunity.CreatedDate AS OppCreatedDate,
    ObjOpportunity.Purpose_of_call__c AS PurposeOfCall,
    ObjOpportunity.Intake_Type__c AS IntakeType,
    ObjOpportunity.Insurance_Category__c AS InsuranceCategory,
    ObjOpportunity.Nurture_Last_Sent__c AS NurtureLastSent,
    ObjOpportunity.Topics_Sent__c AS TopicsSent,
    ObjOpportunity.Nurture_Preference__c AS NurturePreference,
    ObjOpportunity.Nurture_Status__c AS NurtureStatus,
    ObjOpportunity.Contact_Status__c AS ContactStatus,
    Contacts.HasOptedOutOfEmail AS HasOptedOutOfEmail,
    AllSubscribers.Status AS SubscriptionStatus,
    ObjOpportunity.Owner_First_Name__c AS OwnerFirstName,
    ObjOpportunity.Owner_Last_Name__c AS OwnerLastName,
    ObjOpportunity.Owner_Email__c AS OwnerEmail,
    ObjOpportunity.Owner_Phone__c AS OwnerPhone,
    ObjOpportunity.Owner_Address__c AS OwnerAddress,
    ObjOpportunity.Owner_Profile_Name__c AS OwnerProfileName,
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
    ) AS PhoneaDoc,
    (
        SELECT
            COUNT(Name)
        FROM
            Resource_Request__c_Salesforce
        WHERE
            (
                ObjOpportunity.Id = Opportunity__c
                AND Resource_Type__c = 'CFCN'
            )
    ) AS CFCNConnections,
    (
        SELECT
            COUNT(Name)
        FROM
            Fulfillment__c_Salesforce
        WHERE
            (
                ObjOpportunity.Lead__C = Lead__C
                AND Fulfillment_Type__c = 'Welcome Kit'
                AND Method__c = 'Email'
            )
    ) AS LeadWelcomeKitEmailCount,
    (
        SELECT
            COUNT(Name)
        FROM
            Fulfillment__c_Salesforce
        WHERE
            (
                ObjOpportunity.Lead__C = Lead__C
                AND Fulfillment_Type__c = 'Welcome Kit'
                AND Method__c = 'Direct Mail'
            )
    ) AS LeadWelcomeKitDMCount,
    (
        SELECT
            COUNT(Name)
        FROM
            Fulfillment__c_Salesforce
        WHERE
            (
                ObjOpportunity.Id = Opportunity__c
                AND Fulfillment_Type__c = 'Welcome Kit (Caregiver)'
            )
    ) AS CGWelcomeKitCount,
    (
        SELECT
            COUNT(Name)
        FROM
            Fulfillment__c_Salesforce
        WHERE
            (
                ObjOpportunity.Id = Opportunity__c
                AND Fulfillment_Type__c LIKE '%Welcome Kit%'
                AND Method__c = 'Email'
            )
    ) AS TotalOppWelcomeEmailCount,
    (
        SELECT
            COUNT(Name)
        FROM
            Fulfillment__c_Salesforce
        WHERE
            (
                ObjOpportunity.Id = Opportunity__c
                AND Fulfillment_Type__c = 'Welcome Kit'
                AND Method__c = 'Direct Mail'
            )
    ) AS TotalOppWelcomeDMCount,
    (
        SELECT
            COUNT(TopicName)
        FROM
            JourneyTracking_DE J
        WHERE
            (
                ObjOpportunity.Lead__C = J.LeadId
                AND J.JourneyName = 'LeadNurture'
            )
    ) AS LeadNurture_Count,
    (
        SELECT
            COUNT(TopicName)
        FROM
            JourneyTracking_DE J
        WHERE
            (
                ObjOpportunity.Id = J.OpportunityId
                AND J.JourneyName = 'Insurance Approved'
            )
    ) AS InsApprovedNurture_Count,
    (
        SELECT
            COUNT(TopicName)
        FROM
            JourneyTracking_DE J
        WHERE
            (
                ObjOpportunity.Id = J.OpportunityId
                AND J.JourneyName = 'Appointment Scheduled'
            )
    ) AS SNYKNurture_Count,
    (
        SELECT
            COUNT(TopicName)
        FROM
            JourneyTracking_DE J
        WHERE
            (
                ObjOpportunity.Id = J.OpportunityId
                AND J.JourneyName = 'Appointment Canceled'
            )
    ) AS ApptCanceledNurture_Count,
    (
        SELECT
            COUNT(Id)
        FROM
            MR_Patient_Referral__c_Salesforce objReferral
        WHERE
            (
                (
                    (ObjOpportunity.Lead__C = objReferral.Lead__c)
                    OR (ObjOpportunity.Id = objReferral.Opportunity__c)
                )
                AND objReferral.Referral_Source__c = 'Medical Professional'
            )
    ) AS PhysReferralCount
FROM
    [Opportunity_Salesforce] ObjOpportunity
    INNER JOIN [Contact_Salesforce] Contacts ON ObjOpportunity.ContactId__c = Contacts.Id
    LEFT JOIN [Facilities__c_Salesforce] Facility ON (ObjOpportunity.Selected_Facility__c = Facility.Id)
    LEFT JOIN [_ListSubscribers] AllSubscribers ON (
        ObjOpportunity.ContactId__c = AllSubscribers.SubscriberKey
        AND AllSubscribers.ListID = 24
    )
    LEFT JOIN [Cancer_Type_Mapping_DE_Journey] CancerMapping ON (
        ObjOpportunity.Cancer_Type__c = CancerMapping.CancerType
    )
WHERE
    (
        ObjOpportunity.Intake_Type__c IS NULL
        OR ObjOpportunity.Intake_Type__c NOT IN ('Non-Oncology')
    )
    AND ObjOpportunity.CreatedDate >= '2022-10-01'
    AND ObjOpportunity.CreatedDate < '2023-10-01'
    AND (
        (ObjOpportunity.Selected_Facility__c IS NULL)
        OR (Facility.Name LIKE ('%RMC%'))
    )
    /*AND ObjOpportunity.Lead__C IS NOT NULL*/
    AND (
        (ObjOpportunity.Contact_Status__c IS NULL)
        OR (
            ObjOpportunity.Contact_Status__c != 'Duplicate Record'
        )
    )
    /*following requirement limits to Opportunity Record Type of "Prospect Patient"*/
    AND ObjOpportunity.RecordTypeId = '0121C000001RL6JQAW'
