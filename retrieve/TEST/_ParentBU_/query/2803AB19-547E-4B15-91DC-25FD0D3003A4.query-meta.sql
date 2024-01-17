SELECT
    SubscriberKey,
    COUNT(SubscriberKey) AS Sent
FROM
    _Sent
WHERE
    JobID = '228244'
GROUP BY
    SubscriberKey
