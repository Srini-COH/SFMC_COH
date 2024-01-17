SELECT
    se.JobID,
    se.SubscriberID,
    se.SubscriberKey,
    se.EventDate,
    se.Domain,
    se.AccountId
FROM
    _Sent se
WHERE
    se.eventdate > DATEADD(hh, -24, GETDATE())
