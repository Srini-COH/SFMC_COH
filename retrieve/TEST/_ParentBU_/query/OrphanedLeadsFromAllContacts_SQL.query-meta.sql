SELECT
    c.ContactKey,
    l.Id
    /*,
    l.Email,
    l.RecordTypeId,
    l.CreatedDate,
    l.LastModifiedDate,
    l.HasOptedOutOfEmail,
    l.Do_Not_Synch__c
    */
FROM
    AllContacts_DE c
    LEFT JOIN Lead_Salesforce l ON c.ContactKey = l.Id
WHERE
    c.ContactKey LIKE '00Q%'
    AND l.Id IS NULL
