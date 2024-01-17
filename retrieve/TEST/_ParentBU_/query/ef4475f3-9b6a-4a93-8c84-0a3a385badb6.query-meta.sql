SELECT DISTINCT
    J.OpportunityId AS OpportunityID,
    J.ContactId AS ContactId,
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
            COUNT(TopicName)
        FROM
            JourneyTracking_DE
        WHERE
            (
                ObjOpportunity.Id = OpportunityId
                AND JourneyName = 'Appointment Kept'
            )
    ) AS ApptKeptNurture_Count
FROM
    [JourneyTracking_DE] J
    LEFT JOIN [Opportunity_Salesforce] ObjOpportunity ON J.OpportunityId = ObjOpportunity.Id
WHERE
    J.JourneyName = 'Appointment Kept'
    AND J.DateSent >= '2021-10-01'
    AND J.DateSent < '2022-10-01'
