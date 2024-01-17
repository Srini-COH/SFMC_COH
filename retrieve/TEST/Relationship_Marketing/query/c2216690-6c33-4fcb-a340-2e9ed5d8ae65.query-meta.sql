SELECT
    Id AS SubscriberKey,
    Email AS Email,
    CASE
        WHEN Last_RMT_Completed_Date__c IS NOT NULL THEN 'true'
        ELSE 'False'
    END AS Completed_Lead
FROM
    ENT.Lead_Salesforce
