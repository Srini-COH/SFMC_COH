SELECT
    c.id,
    c.Do_Not_Synch__c AS [Do_Not_Synch__c],
    c.Email AS [EmailAddress],
    s.SubscriberType AS [SubscriberType],
    c.CreatedDate AS CreatedDate,
    c.RecordTypeId AS ContactRecordType,
    c.HasOptedOutOfEmail AS EmailOptOut
FROM
    Contact_Salesforce c
    LEFT JOIN _subscribers s ON c.id = s.subscriberkey
WHERE
    s.subscriberkey IS NULL
    AND s.EmailAddress IS NULL
