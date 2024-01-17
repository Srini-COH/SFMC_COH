SELECT DISTINCT
    AllSubscribers.SubscriberKey AS SubscriberKey,
    AllSubscribers.Status AS Status,
    AllSubscribers.EmailAddress AS EmailAddress,
    AllSubscribers.DateUndeliverable AS DateUndeliverable,
    AllSubscribers.DateJoined AS DateJoined,
    AllSubscribers.DateUnsubscribed AS DateUnsubscribed,
    Contacts.Marketing_Cloud_Status__c AS CRM_MCStatus
FROM
    [Contact_Salesforce] Contacts
    INNER JOIN [_Subscribers] AllSubscribers ON Contacts.Id = AllSubscribers.SubscriberKey
WHERE
    (
        (AllSubscribers.DateUndeliverable > '2023-08-23')
        OR (AllSubscribers.DateJoined > '2023-08-23')
        OR (AllSubscribers.DateUnsubscribed > '2023-08-23')
    )
    /*(
    (AllSubscribers.DateUndeliverable > Dateadd(day, -23, Getdate()) OR
    AllSubscribers.DateJoined > Dateadd(day, -23, Getdate()) OR
    AllSubscribers.DateUnsubscribed > Dateadd(day, -23, Getdate()))
    )*/
    AND (
        (
            Contacts.Marketing_Cloud_Status__c <> AllSubscribers.Status
        )
        OR (Contacts.Marketing_Cloud_Status__c IS NULL)
    )
    AND AllSubscribers.SubscriberKey LIKE '003%'
