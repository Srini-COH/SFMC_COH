SELECT
    sl.SubscriberKey AS SubscriberKey,
    sl.SubID AS SubscriberID,
    sl.EmailAddr AS EmailAddress,
    sl.EmailName_ AS EmailName,
    j.JourneyName AS JourneyName,
    j.VersionNumber AS JourneyVersion,
    s.EventDate AS SentDate,
    CASE
        WHEN job.DeliveredTime IS NOT NULL THEN CONVERT(NVARCHAR, job.DeliveredTime)
        WHEN b.EventDate IS NOT NULL THEN 'False'
        WHEN o.EventDate IS NOT NULL
        OR c.EventDate IS NOT NULL THEN 'True'
        WHEN s.EventDate > DATEADD(MINUTE, -15, GETDATE()) THEN 'Pending'
        ELSE 'True'
    END AS Delivered,
    CASE
        WHEN o.EventDate IS NOT NULL THEN o.EventDate
        WHEN c.EventDate IS NOT NULL THEN c.EventDate
    END AS FirstOpenDate,
    c.EventDate AS FirstClickDate,
    b.EventDate AS BounceDate,
    sl.JobID AS JobID,
    sl.ListID AS ListID,
    sl.BatchID AS BatchID,
    sl.TriggeredSendID AS TriggeredSendID,
    sl.ErrorCode AS ErrorCode
FROM
    _Sent AS s
    LEFT JOIN _Job job ON s.JobID = job.JobID
    LEFT JOIN _Open AS o ON s.JobID = o.JobID
    AND s.ListID = o.ListID
    AND s.BatchID = o.BatchID
    AND s.SubscriberID = o.SubscriberID
    AND o.IsUnique = 1
    LEFT JOIN _Click AS c ON s.JobID = c.JobID
    AND s.ListID = c.ListID
    AND s.BatchID = c.BatchID
    AND s.SubscriberID = c.SubscriberID
    AND c.IsUnique = 1
    LEFT JOIN _Bounce AS b ON s.JobID = b.JobID
    AND s.ListID = b.ListID
    AND s.BatchID = b.BatchID
    AND s.SubscriberID = b.SubscriberID
    AND b.IsUnique = 1
    LEFT JOIN TechnicalSendLog AS sl ON s.JobID = sl.JobID
    AND s.ListID = sl.ListID
    AND s.BatchID = sl.BatchID
    AND s.SubscriberID = sl.SubID
    LEFT JOIN _JourneyActivity AS ja ON s.TriggererSendDefinitionObjectID = ja.JourneyActivityObjectID
    LEFT JOIN _Journey AS j ON ja.VersionID = j.VersionID
WHERE
    /*sl.SubscriberKey IS NOT NULL */
    /*AND*/
    CONVERT(DATE, s.EventDate) >= DATEADD(MONTH, -1, CONVERT(DATE, GETDATE()))
