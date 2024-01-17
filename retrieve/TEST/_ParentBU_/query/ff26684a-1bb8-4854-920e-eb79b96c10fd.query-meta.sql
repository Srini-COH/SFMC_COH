SELECT
    c.Id AS [Contact ID],
    c.Do_Not_Synch__c AS DoNotSync
FROM
    Contact_Salesforce c
    LEFT JOIN MedicalStaff_DoNotSync m ON m.[Contact ID] = c.Id
WHERE
    c.Do_Not_Synch__c = 1
    AND m.[Contact Id] IS NULL
