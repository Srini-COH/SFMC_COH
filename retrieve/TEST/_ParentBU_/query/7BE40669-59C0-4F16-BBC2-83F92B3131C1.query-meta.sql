SELECT DISTINCT
    Contacts.Id AS SubscriberKey,
    AllSubscribers.Status AS Status,
    AllSubscribers.EmailAddress AS EmailAddress,
    Contacts.Marketing_Cloud_Status__c AS CRM_MCStatus
FROM
    [Contact_Salesforce] Contacts
    INNER JOIN [_Subscribers] AllSubscribers ON Contacts.Id = AllSubscribers.SubscriberKey
WHERE
    AllSubscribers.Status = 'active'
    AND (
        (Contacts.Marketing_Cloud_Status__c != 'active')
        OR (Contacts.Marketing_Cloud_Status__c IS NULL)
    )
    /*AND Contacts.Marketing_Cloud_Status__c <> AllSubscribers.Status*/
