SELECT
    c.Id AS SubscriberKey,
    c.Email AS Email,
    CASE
        WHEN c.Last_RMT_Completed_Date__c IS NOT NULL THEN 'true'
        WHEN c.Last_RMT_Completed_Date__c IS NULL THEN 'false'
        WHEN c.Risk_Assessment_LeadId__c IS NOT NULL
        AND Last_RMT_Completed_Date__c IS NOT NULL THEN 'True'
        WHEN c.Risk_Assessment_LeadId__c IS NOT NULL
        AND Last_RMT_Completed_Date__c IS NULL THEN 'false'
        WHEN c.Risk_Assessment_LeadId__c IS NULL
        AND Last_RMT_Completed_Date__c IS NOT NULL THEN 'false'
        WHEN c.Risk_Assessment_LeadId__c IS NULL
        AND Last_RMT_Completed_Date__c IS NULL THEN 'false'
    END AS Completed_Contact
FROM
    ENT.Contact_Salesforce c
WHERE
    Last_RMT_Start_Date__c IS NOT NULL
    AND Last_RMT_Completed_Date__c IS NULL
    AND RMT_Opt_In_Status__c = 'Double Opt In'
    AND Cancer_Status_Risk_Assessment__c <> 'Currently diagnosed with cancer'
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
