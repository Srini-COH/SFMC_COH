SELECT
    SubscriberKey,
    COUNT(SubscriberKey) AS [Unique Click]
FROM
    _Click
WHERE
    JobID = '228244'
    AND IsUnique = 1
GROUP BY
    SubscriberKey
