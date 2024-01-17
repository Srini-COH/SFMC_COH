SELECT
    l.SubscriberKey,
    l.EmailAddress,
    l.Status,
    l.CreatedDate,
    l.AddedBy,
    l.AddMethod,
    l.DateUnsubscribed,
    s.JobID,
    s.ListID,
    s.EventDate,
    s.BatchID,
    j.EmailName,
    j.SendClassification,
    j.FromEmail,
    b.BounceCategory,
    b.BounceSubcategory,
    b.BounceType
FROM
    [_listsubscribers] l
    LEFT JOIN _Sent s ON l.SubscriberKey = s.SubscriberKey
    LEFT JOIN _Job j ON s.JobID = j.JobID
    LEFT JOIN _Bounce b ON j.JobID = b.JobID
WHERE
    l.ListID = 24
    AND l.SubscriberKey LIKE '%_@__%.__%'
    AND l.Status IN ('Bounced', 'Held', 'Unsubscribed')
    AND s.JobID IS NOT NULL
