SELECT
    Id AS LeadID,
    FirstName AS FirstName,
    Email AS Email,
    RMT_Opt_In_Status__c AS RMT_Opt_In_Status__c,
    HasOptedOutOfEmail AS EmailOptOut,
    Last_RMT_Start_Date__c AS RMT_Start_Date,
    Last_RMT_Completed_Date__c AS RMT_Completed_Date
FROM
    ENT.Lead_Salesforce
WHERE
    Last_RMT_Start_Date__c IS NOT NULL
    AND RMT_Opt_In_Status__c = 'Single Opt In'
    AND (
        (Last_RMT_Completed_Date__c IS NOT NULL)
        OR (
            Cancer_Status_Risk_Assessment__c = 'Currently diagnosed with cancer'
        )
    )
    /*AND DATEDIFF(dd, Last_RMT_Start_Date__c AT TIME ZONE 'Central Standard Time', GetDate() AT TIME ZONE 'Central Standard Time') >= 1 */
    AND DATEDIFF(
        dd,
        Last_RMT_Start_Date__c AT TIME ZONE 'Central Standard Time',
        GETDATE() AT TIME ZONE 'Central Standard Time'
    ) < 20
