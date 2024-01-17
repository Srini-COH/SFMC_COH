SELECT
    Id AS SubscriberKey,
    FirstName AS FirstName,
    Email AS Email,
    CASE
        WHEN Last_RMT_Completed_Date__c IS NOT NULL THEN 'True'
        WHEN Last_RMT_Completed_Date__c IS NULL THEN 'False'
    END AS Completed_Lead
FROM
    ENT.Lead_Salesforce
WHERE
    Last_RMT_Start_Date__c IS NOT NULL
    AND Last_RMT_Completed_Date__c IS NULL
    AND Cancer_Status_Risk_Assessment__c != 'Currently diagnosed with cancer'
    AND DATEDIFF(
        hh,
        Last_RMT_Start_Date__c AT TIME ZONE 'Central Standard Time',
        GETDATE() AT TIME ZONE 'Central Standard Time'
    ) >= 1
    AND DATEDIFF(
        hh,
        Last_RMT_Start_Date__c AT TIME ZONE 'Central Standard Time',
        GETDATE() AT TIME ZONE 'Central Standard Time'
    ) < 3
    AND FirstName = 'RMTTest'
