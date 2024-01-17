SELECT DISTINCT
    Contacts.Id AS SubscriberKey,
    Contacts.Email AS EmailAddress,
    AllSubscribers.EmailAddress AS AllSubscribersEmail,
    AllSubscribers.Status AS AllSubscribersStatus
FROM
    [Contact_Salesforce] Contacts
    INNER JOIN [_ListSubscribers] AllSubscribers ON Contacts.Id = AllSubscribers.SubscriberKey
WHERE
    Contacts.Email <> AllSubscribers.EmailAddress
    AND AllSubscribers.Status NOT IN ('Unsubscribed')
