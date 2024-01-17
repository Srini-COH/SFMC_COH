SELECT
    l.Id AS SubscriberKey,
    l.Email AS Email
FROM
    ENT.Lead_Salesforce AS l
WHERE
    Last_RMT_Start_Date__c IS NOT NULL
    AND Last_RMT_Completed_Date__c IS NULL
    AND Last_RMT_Start_Date__c >= DATEADD(HOUR, -1, GETDATE())
    AND RMT_Opt_In_Status__c = 'Double Opt In'
    AND Cancer_Status_Risk_Assessment__c != 'Currently diagnosed with cancer'
    AND FirstName = 'RMTTest'
