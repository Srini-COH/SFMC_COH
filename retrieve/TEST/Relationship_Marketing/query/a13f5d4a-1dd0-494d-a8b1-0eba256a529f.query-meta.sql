SELECT
    c.Id AS SubscriberKey,
    c.Email AS Email
FROM
    ENT.Contact_Salesforce AS c
WHERE
    Last_RMT_Start_Date__c IS NOT NULL
    AND Last_RMT_Completed_Date__c IS NULL
    AND RMT_Opt_In_Status__c = 'Double Opt In'
    AND Cancer_Status_Risk_Assessment__c != 'Currently diagnosed with cancer'
