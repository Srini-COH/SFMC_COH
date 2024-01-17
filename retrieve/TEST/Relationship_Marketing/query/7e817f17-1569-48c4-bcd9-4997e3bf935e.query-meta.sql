SELECT
    a.SubscriberKey,
    CASE
        WHEN c.Last_RMT_Completed_Date__c IS NOT NULL THEN 'true'
        WHEN c.Last_RMT_Completed_Date__c IS NULL THEN 'false'
        WHEN c.Risk_Assessment_LeadId__c IS NOT NULL
        AND c.Last_RMT_Completed_Date__c IS NOT NULL THEN 'True'
        WHEN c.Risk_Assessment_LeadId__c IS NOT NULL
        AND c.Last_RMT_Completed_Date__c IS NULL THEN 'false'
        WHEN c.Risk_Assessment_LeadId__c IS NULL
        AND c.Last_RMT_Completed_Date__c IS NOT NULL THEN 'false'
        WHEN c.Risk_Assessment_LeadId__c IS NULL
        AND c.Last_RMT_Completed_Date__c IS NULL THEN 'false'
    END AS Completed_Contact
FROM
    Abandoner_Email a
    LEFT JOIN ENT.Contact_Salesforce c ON a.SubscriberKey = c.Id
