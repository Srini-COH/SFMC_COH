SELECT DISTINCT
    LEAD.Id AS SubscriberKey,
    LEAD.Email AS EmailAddress,
    AllSubscribers.EmailAddress AS AllSubscribersEmail,
    'Active' AS Status,
    AllSubscribers.Status AS AllSubscribersStatus
FROM
    [Lead_Salesforce] LEAD
    INNER JOIN [_Subscribers] AllSubscribers ON LEAD.Id = AllSubscribers.SubscriberKey
WHERE
    LEAD.Email <> AllSubscribers.EmailAddress
    AND AllSubscribers.Status = 'Active'
