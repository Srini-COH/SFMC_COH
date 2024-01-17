SELECT
    Id AS SubscriberKey,
    FirstName AS FirstName,
    Email AS Email,
    CASE
        WHEN Last_RMT_Completed_Date__c IS NOT NULL THEN 'True'
        WHEN Last_RMT_Completed_Date__c IS NULL THEN 'False'
    END AS Completed_Lead,
    Last_RMT_Start_Date__c AS Last_RMT_Start_Date,
    IsConverted AS Converted,
    CASE
        WHEN RecordTypeId = '0121C000001pMVWQA2' THEN 'Risk Assessment'
        WHEN RecordTypeId = '0121C000001RL6FQAW' THEN 'Empowerment'
    END AS LeadRecordType,
    RMT_Opt_In_Status__c AS RMTOptInStatus,
    Cancer_Status_Risk_Assessment__c AS RMTCancerStatus
FROM
    ENT.Lead_Salesforce
WHERE
    Last_RMT_Start_Date__c IS NOT NULL
    AND Last_RMT_Completed_Date__c IS NULL
    AND Cancer_Status_Risk_Assessment__c != 'Currently diagnosed with cancer'
    AND IsConverted = '0'
    AND RMT_Opt_In_Status__c != 'Unsubscribed'
    AND (
        (Contact_Status__c IS NULL)
        OR (Contact_Status__c != 'Duplicate Record')
    )
    AND DATEDIFF(
        dd,
        Last_RMT_Start_Date__c AT TIME ZONE 'Central Standard Time',
        GETDATE() AT TIME ZONE 'Central Standard Time'
    ) >= 4
    AND (
        DATEDIFF(
            dd,
            Last_RMT_Start_Date__c AT TIME ZONE 'Central Standard Time',
            GETDATE() AT TIME ZONE 'Central Standard Time'
        ) < 7
    )
    /*AND FirstName = 'RMTTest'*/
