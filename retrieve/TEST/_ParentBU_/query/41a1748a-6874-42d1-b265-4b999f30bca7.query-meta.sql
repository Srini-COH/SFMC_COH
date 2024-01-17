SELECT DISTINCT
    Contacts.Id AS SubscriberKey,
    Contacts.Email AS EmailAddress,
    AllSubscribers.EmailAddress AS AllSubscribersEmail,
    'Active' AS Status,
    AllSubscribers.Status AS AllSubscribersStatus
FROM
    [Contact_Salesforce] Contacts
    INNER JOIN [_ListSubscribers] AllSubscribers ON Contacts.Id = AllSubscribers.SubscriberKey
WHERE
    AllSubscribers.Status IN ('Held', 'Bounced')
    AND Contacts.Email <> AllSubscribers.EmailAddress
    AND Contacts.Email IS NOT NULL
    AND Contacts.Email <> ''
