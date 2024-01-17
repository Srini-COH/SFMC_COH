SELECT DISTINCT
    J.LeadId AS LeadId,
    ObjOpportunity.Id AS OpportunityID,
    ObjOpportunity.ContactId__c AS ContactId,
    ObjOpportunity.StageName AS Stage,
    ObjOpportunity.Last_Stage__c AS LastStage,
    LEAD.Status AS LeadStatus,
    LEAD.CreatedDate AS LeadCreatedDate,
    ObjOpportunity.CreatedDate AS OppCreatedDate,
    (
        SELECT
            COUNT(TopicName)
        FROM
            JourneyTracking_DE
        WHERE
            (
                J.LeadId = LeadId
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
    LEFT JOIN [Lead_Salesforce] LEAD ON LEAD.Id = J.LeadId
    LEFT JOIN [Opportunity_Salesforce] ObjOpportunity ON LEAD.ConvertedOpportunityId = ObjOpportunity.Id
WHERE
    J.JourneyName = 'LeadNurture'
    AND J.DateSent >= '2020-07-01'
    AND J.DateSent <= '2021-06-30'
