SELECT DISTINCT
    s.SubscriberKey,
    s.JobID,
    s.BatchID,
    S.eventdate AS 'SentDate'
FROM
    [_sent] s
    LEFT JOIN [_open] o ON s.JobID = o.JobID
WHERE
    (o.SubscriberID IS NULL)
