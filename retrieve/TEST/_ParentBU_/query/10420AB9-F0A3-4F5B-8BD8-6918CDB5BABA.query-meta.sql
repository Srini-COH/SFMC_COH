SELECT
    SubscriberKey,
    COUNT(SubscriberKey) AS [Unique Open]
FROM
    _open
WHERE
    JobID = '228244'
    AND IsUnique = 1
GROUP BY
    SubscriberKey
