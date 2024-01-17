SELECT DISTINCT
    ObjOpportunity.Id AS OpportunityID,
    ObjOpportunity.ContactId__c AS ContactID,
    LEAD.Id AS LeadId,
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
                LEAD.Id = LeadId
                AND JourneyName = 'LeadNurture'
                AND (
                    DateSent >= '2018-07-01'
                    AND DateSent < '2019-07-01'
                )
            )
    ) AS LeadNurture_Count_FY19,
    (
        SELECT
            COUNT(TopicName)
        FROM
            JourneyTracking_DE
        WHERE
            (
                ObjOpportunity.Id = OpportunityId
                AND JourneyName = 'Insurance Approved'
                AND (
                    DateSent >= '2018-07-01'
                    AND DateSent < '2019-07-01'
                )
            )
    ) AS InsApprovedNurture_Count_FY19,
    (
        SELECT
            COUNT(TopicName)
        FROM
            JourneyTracking_DE
        WHERE
            (
                ObjOpportunity.Id = OpportunityId
                AND JourneyName = 'Appointment Scheduled'
                AND (
                    DateSent >= '2018-07-01'
                    AND DateSent < '2019-07-01'
                )
            )
    ) AS SNYKNurture_Count_FY19
FROM
    [Lead_Salesforce] LEAD
    LEFT JOIN [Opportunity_Salesforce] ObjOpportunity ON LEAD.ConvertedOpportunityId = ObjOpportunity.Id
    LEFT JOIN [Facilities__c_Salesforce] Facility ON (ObjOpportunity.Selected_Facility__c = Facility.Id)
    LEFT JOIN [Cancer_Type_Mapping_DE_Journey] CancerMapping ON (
        ObjOpportunity.Cancer_Type__c = CancerMapping.CancerType
    )
    LEFT JOIN [JourneyTracking_DE] JourneyLead ON LEAD.Id = JourneyLead.LeadId
    LEFT JOIN [JourneyTracking_DE] JourneyOpp ON LEAD.ConvertedOpportunityId = JourneyOpp.OpportunityId
WHERE
    (
        JourneyLead.LeadId = LEAD.Id
        AND JourneyLead.DateSent >= '2018-07-01'
        AND JourneyLead.DateSent <= '2019-06-30'
    )
    OR (
        JourneyOpp.OpportunityId = LEAD.ConvertedOpportunityId
        AND JourneyOpp.DateSent >= '2018-07-01'
        AND JourneyOpp.DateSent <= '2019-06-30'
    )
