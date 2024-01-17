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
    ) AS ApptCanceledNurture_Count,
    (
        SELECT
            COUNT(Id)
        FROM
            MR_Patient_Referral__c_Salesforce objReferral
        WHERE
            (
                (
                    (J.LeadId = objReferral.Lead__c)
                    OR (
                        LEAD.ConvertedOpportunityId = objReferral.Opportunity__c
                    )
                )
                AND Referral_Source__c = 'Medical Professional'
            )
    ) AS PhysReferralCount
    /*Consider adding:
    Earliest DateSent where J.JourneyName ='LeadNurture'
    Latest DateSent where J.JourneyName ='LeadNurture'
    TopicName on row with Latest DateSent where J.JourneyName ='LeadNurture'*/
FROM
    [JourneyTracking_DE] J
    LEFT JOIN [Lead_Salesforce] LEAD ON LEAD.Id = J.LeadId
    LEFT JOIN [Opportunity_Salesforce] ObjOpportunity ON LEAD.ConvertedOpportunityId = ObjOpportunity.Id
WHERE
    J.JourneyName = 'LeadNurture'
