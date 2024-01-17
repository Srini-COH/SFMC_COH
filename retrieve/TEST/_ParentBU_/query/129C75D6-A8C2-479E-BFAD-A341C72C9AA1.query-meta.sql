SELECT
    Id,
    Marketing_Cloud_Status__c
FROM
    Contact_Salesforce
WHERE
    Marketing_Cloud_Status__c IS NOT NULL
