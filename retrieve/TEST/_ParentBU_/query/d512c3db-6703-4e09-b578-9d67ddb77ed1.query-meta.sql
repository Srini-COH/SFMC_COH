SELECT
    Id,
    Do_Not_Synch__c AS DoNotSync
FROM
    Contact_Salesforce
WHERE
    Do_Not_Synch__c = 1
