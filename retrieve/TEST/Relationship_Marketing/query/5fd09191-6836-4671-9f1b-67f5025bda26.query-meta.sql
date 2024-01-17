SELECT
    Id AS SubscriberKey,
    Email AS Email,
    FirstName AS FirstName,
    Last_RMT_Start_Date__c AS Last_RMT_Start_Date,
    Last_RMT_Completed_Date__c AS Last_RMT_Completed_Date,
    Cancer_Status_Risk_Assessment__c AS RMTCancerStatus,
    RMT_Opt_In_Status__c AS RMTOptInStatus,
    Count_of_Risk_Assessments_Started__c AS RMT_Started_Count,
    RMT_Subscribed_Date__c AS RMT_Subscribed_Date,
    RMT_Unsubscribed_Date__c AS RMT_Unsubscribed_Date,
    RMT_Results_Email_Status__c AS RMT_Result_Email_Status,
    RMT_Results_Email_Sent_Date__c AS RMT_Result_Email_Date,
    RMT_Employer_Name__c AS RMT_Employer_Name,
    IsConverted AS Converted,
    CASE
        WHEN RecordTypeId = '0121C000001pMVWQA2' THEN 'Risk Assessment'
        WHEN RecordTypeId = '0121C000001RL6FQAW' THEN 'Empowerment'
    END AS LeadRecordType,
    CASE
        WHEN Last_RMT_Completed_Date__c IS NOT NULL THEN 'True'
        WHEN Last_RMT_Completed_Date__c IS NULL THEN 'False'
    END AS Completed_Lead,
    Contact_Status__c AS ContactStatus
FROM
    ENT.Lead_Salesforce
WHERE
    Last_RMT_Start_Date__c IS NOT NULL
    AND (
        (Contact_Status__c IS NULL)
        OR (Contact_Status__c != 'Duplicate Record')
    )
