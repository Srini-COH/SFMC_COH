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
    ) AS ApptCanceledNurture_Count
FROM
    [JourneyTracking_DE] J
    LEFT JOIN [Opportunity_Salesforce] ObjOpportunity ON J.OpportunityId = ObjOpportunity.Id
    LEFT JOIN [Facility_Visits__c_Salesforce] FV ON J.OpportunityId = FV.Opportunity__c
WHERE
    J.JourneyName = 'Insurance Approved'
    AND J.DateSent >= '2020-07-01'
    AND J.DateSent <= '2021-06-30'
