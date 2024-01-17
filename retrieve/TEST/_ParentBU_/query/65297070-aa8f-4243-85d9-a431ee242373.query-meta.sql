SELECT
    se.JobID,
    se.SubscriberID,
    se.SubscriberKey,
    se.EventDate AS 'SentDate',
    O.EventDate AS 'OpenDate'
FROM
    _Sent se
    LEFT JOIN _Open o ON se.Subscriberkey = o.Subscriberkey
WHERE
    O.Subscriberkey = 'Null'
