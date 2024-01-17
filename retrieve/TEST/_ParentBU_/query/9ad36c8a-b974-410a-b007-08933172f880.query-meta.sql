SELECT
    SubscriberKey,
    EventDate
FROM
    _Job j
    INNER JOIN _Sent s ON s.JobID = j.JobID
WHERE
    EmailName = 'SNYK - Integrative Care'
    AND EventDate >= DATEADD(d, -7, GETDATE())
