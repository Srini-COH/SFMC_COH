SELECT DISTINCT
    AllSubscribers.SubscriberKey AS SubscriberKey,
    AllSubscribers.Status AS Status,
    AllSubscribers.EmailAddress AS EmailAddress
FROM
    [Lead_Salesforce] Leads
    INNER JOIN [_Subscribers] AllSubscribers ON Leads.Id = AllSubscribers.SubscriberKey
WHERE
    (
        AllSubscribers.DateUndeliverable > DATEADD(DAY, -15, GETDATE())
        OR AllSubscribers.DateJoined > DATEADD(DAY, -15, GETDATE())
        OR AllSubscribers.DateUnsubscribed > DATEADD(DAY, -15, GETDATE())
    )
    AND Leads.Marketing_Cloud_Status__c <> AllSubscribers.Status
    AND AllSubscribers.SubscriberKey LIKE '003%'
