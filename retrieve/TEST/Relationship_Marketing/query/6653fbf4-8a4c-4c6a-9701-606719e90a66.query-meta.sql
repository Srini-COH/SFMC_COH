SELECT
    Id AS SubscriberKey,
    CASE
        WHEN (
            Last_RMT_Completed_Date__c IS NOT NULL
            AND Cancer_Status_Risk_Assessment__c != 'Currently diagnosed with cancer'
        ) THEN 'TRUE'
        ELSE 'FALSE'
    END AS Completed_Lead
FROM
    ENT.Lead_Salesforce
