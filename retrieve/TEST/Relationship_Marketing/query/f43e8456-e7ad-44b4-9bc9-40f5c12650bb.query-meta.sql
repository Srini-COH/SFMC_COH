SELECT
    Id AS SubscriberKey,
    Risk_Assessment_LeadId__c AS Rmt_Lead_Id,
    CASE
        WHEN (
            Last_RMT_Completed_Date__c IS NOT NULL
            AND Cancer_Status_Risk_Assessment__c != 'Currently diagnosed with cancer'
        ) THEN 'TRUE'
        ELSE 'FALSE'
    END AS Completed_Contact
FROM
    Ent.Contact_Salesforce
