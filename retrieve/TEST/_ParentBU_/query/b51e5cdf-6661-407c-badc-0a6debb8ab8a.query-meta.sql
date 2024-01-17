SELECT
    s.SubscriberKey,
    s.EventDate,
    EmailName
FROM
    _Sent s
    INNER JOIN _Job j ON s.JobID = j.JobID
WHERE
    EmailName = 'SNYK - Integrative Care'
    AND s.EventDate >= DATEADD(d, -7, GETDATE())
    /* AND EXISTS (SELECT SubscriberKey FROM _Open WHERE SubscriberKey = s.SubscriberKey and JobID = s.JobID) */
