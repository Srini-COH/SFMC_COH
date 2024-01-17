SELECT DISTINCT
    s.SubscriberKey,
    s.JobID,
    s.BatchID,
    S.eventdate AS 'SentDate'
FROM
    [_sent] s
    LEFT JOIN [_open] o ON s.subscriberkey = o.subscriberkey
WHERE
    o.subscriberkey IS NULL
    AND S.eventdate >= DATEADD(dd, -150, GETDATE())
