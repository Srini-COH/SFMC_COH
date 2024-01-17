SELECT
    l.SubscriberKey,
    l.EmailAddress,
    l.Status,
    l.CreatedDate,
    l.AddedBy,
    l.AddMethod,
    l.DateUnsubscribed
FROM
    [_listsubscribers] l
WHERE
    l.ListID = 24
    AND l.SubscriberKey LIKE '%_@__%.__%'
    AND l.Status IN ('Bounced', 'Held', 'Unsubscribed')
