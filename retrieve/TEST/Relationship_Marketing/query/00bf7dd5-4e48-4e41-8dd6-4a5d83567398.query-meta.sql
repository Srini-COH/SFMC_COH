SELECT
    a.SubscriberKey,
    CASE
        WHEN l.Last_RMT_Completed_Date__c IS NOT NULL THEN 'True'
        WHEN l.Last_RMT_Completed_Date__c IS NULL THEN 'False'
    END AS Completed_Lead
FROM
    Abandoner_Email a
    LEFT JOIN ENT.Lead_Salesforce l ON a.SubscriberKey = l.Id
