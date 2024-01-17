SELECT
    s.SubscriberKey,
    sub.EmailAddress,
    s.EventDate AS SendEventDate,
    j.DeliveredTime,
    j.EmailName
FROM
    _Sent s
    INNER JOIN _Job j ON j.JobID = s.JobID
    INNER JOIN _Subscribers sub ON s.SubscriberKey = sub.SubscriberKey
WHERE
    j.EmailID = '15958'
