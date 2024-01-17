SELECT
    se.JobID,
    se.SubscriberID,
    s.SubscriberKey,
    se.EventDate,
    se.Domain
FROM
    _Sent se
    LEFT JOIN _Subscribers s ON se.Subscriberid = s.Subscriberid
WHERE
    eventdate = CONVERT(DATE, GETDATE())
