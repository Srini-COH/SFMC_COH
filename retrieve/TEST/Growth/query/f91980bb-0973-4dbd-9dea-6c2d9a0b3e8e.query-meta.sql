SELECT
    s.SubscriberKey,
    sub.EmailAddress
FROM
    _Job j
    INNER JOIN _Sent s ON j.JobID = s.JobID
    INNER JOIN _Subscribers sub ON s.SubscriberKey = sub.SubscriberKey
WHERE
    j.EmailID = '19749'
