SELECT DISTINCT
    J.OpportunityId AS OpportunityID,
    J.ContactId AS ContactId,
    ObjOpportunity.StageName AS Stage,
    ObjOpportunity.Last_Stage__c AS LastStage,
    ObjOpportunity.CreatedDate AS OppCreatedDate,
    (
        SELECT
            COUNT(Id)
        FROM
            Facility_Visits__c_Salesforce
        WHERE
            (
                J.OpportunityId = FV.Opportunity__c
                AND FV.ctca_apptstatus__c != ('Appt Entry Error')
                AND (
                    FV.ctca_apptdate__c >= '2019-07-01'
                    AND FV.ctca_apptdate__c < '2020-07-01'
                )
            )
    ) AS TotalFY20ApptCount,
    (
        SELECT
            COUNT(Id)
        FROM
            Facility_Visits__c_Salesforce
        WHERE
            (
                J.OpportunityId = FV.Opportunity__c
                AND FV.ctca_apptstatus__c = ('Scheduled')
                AND (
                    FV.ctca_apptdate__c >= '2019-07-01'
                    AND FV.ctca_apptdate__c < '2020-07-01'
                )
            )
    ) AS FY20KeptApptCount,
    (
        SELECT
            COUNT(Id)
        FROM
            Facility_Visits__c_Salesforce
        WHERE
            (
                J.OpportunityId = FV.Opportunity__c
                AND FV.ctca_apptstatus__c = ('Remote Telehealth Screening')
                AND (
                    FV.ctca_apptdate__c >= '2019-07-01'
                    AND FV.ctca_apptdate__c < '2020-07-01'
                )
            )
    ) AS FY20TelehealthCount,
    (
        SELECT
            COUNT(Id)
        FROM
            Facility_Visits__c_Salesforce
        WHERE
            (
                J.OpportunityId = FV.Opportunity__c
                AND (
                    FV.ctca_1sttxdate__c >= '2019-07-01'
                    AND FV.ctca_apptdate__c < '2020-07-01'
                )
            )
    ) AS FY20TxCount,
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
    ) AS SNYKNurture_Count
FROM
    [JourneyTracking_DE] J
    LEFT JOIN [Opportunity_Salesforce] ObjOpportunity ON J.OpportunityId = ObjOpportunity.Id
    INNER JOIN [Facility_Visits__c_Salesforce] FV ON J.OpportunityId = FV.Opportunity__c
WHERE
    J.JourneyName = 'Appointment Scheduled'
    /*	AND J.DateSent >='2019-07-01'
    AND J.DateSent <='2020-06-30'*/
