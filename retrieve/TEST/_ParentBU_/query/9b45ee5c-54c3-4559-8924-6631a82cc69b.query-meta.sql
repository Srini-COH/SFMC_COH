SELECT DISTINCT
    J.OpportunityId AS OpportunityID,
    ObjOpportunity.ContactId AS ContactID,
    ObjOpportunity.Lead__c AS LeadID,
    ObjOpportunity.StageName AS Stage,
    ObjOpportunity.Last_Stage__c AS LastStage,
    ObjOpportunity.CreatedDate AS OppCreatedDate,
    (
        SELECT
            COUNT(TopicName)
        FROM
            JourneyTracking_DE
        WHERE
            (
                ObjOpportunity.Lead__C = LeadId
                AND JourneyName = 'LeadNurture'
            )
    ) AS LeadNurture_Count,
    (
        SELECT
            COUNT(TopicName)
        FROM
            JourneyTracking_DE
        WHERE
            (
                ObjOpportunity.Id = OpportunityId
                AND JourneyName = 'Insurance Approved'
            )
    ) AS InsApprovedNurture_Count,
    (
        SELECT
            COUNT(TopicName)
        FROM
            JourneyTracking_DE
        WHERE
            (
                ObjOpportunity.Id = OpportunityId
                AND JourneyName = 'Appointment Scheduled'
            )
    ) AS SNYKNurture_Count,
    (
        SELECT
            COUNT(TopicName)
        FROM
            JourneyTracking_DE
        WHERE
            (
                ObjOpportunity.Id = OpportunityId
                AND JourneyName = 'Appointment Canceled'
            )
    ) AS ApptCanceledNurture_Count,
    (
        SELECT
            COUNT(Id)
        FROM
            MR_Patient_Referral__c_Salesforce objReferral
        WHERE
            (
                (J.OpportunityId = objReferral.Opportunity__c)
                AND (Referral_Source__c = 'Medical Professional')
            )
    ) AS PhysReferralCount
    /*Consider adding:
    Earliest DateSent where J.JourneyName ='Appointment Canceled' as FirstSendDate
    Latest DateSent where J.JourneyName ='Appointment Canceled' as LastSendDate
    TopicName on row with Latest DateSent where J.JourneyName ='Appointment Canceled' as LastTopicSent*/
FROM
    [JourneyTracking_DE] J
    LEFT JOIN [Opportunity_Salesforce] ObjOpportunity ON J.OpportunityId = ObjOpportunity.Id
WHERE
    J.JourneyName = 'Appointment Canceled'
