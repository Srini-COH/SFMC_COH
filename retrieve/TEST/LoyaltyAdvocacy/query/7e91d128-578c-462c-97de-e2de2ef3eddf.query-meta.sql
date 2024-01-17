SELECT DISTINCT
    s.SubscriberKey,
    s.JobID,
    s.BatchID,
    S.eventdate AS 'SentDate'
FROM
    [_sent] s
    LEFT JOIN [_open] o ON s.JobID = o.JobID
    AND s.SubscriberID = o.SubscriberID
    AND o.IsUnique = 1
WHERE
    (o.SubscriberID IS NULL)
