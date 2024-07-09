SELECT
    s.SubscriberKey,
    ls.EmailAddress,
    j.EmailName,
    j.EmailSubject,
    j.FromName,
    j.FromEmail,
    s.EventDate AS SentDate,
    o.EventDate AS OpenDate,
    op.Opens AS NumberOfOpens,
    c.EventDate AS ClickDate,
    cl.Clicks AS NumberOfClicks,
    url.URLs AS NumberOfLinksClicked,
    b.EventDate AS BouncedDate,
    b.BounceCategory,
    u.EventDate AS UnsubscribedDate,
    j.AccountID AS MID
FROM
    _Sent s
    LEFT JOIN ENT.DV_Job_Loyalty j ON s.JobID = j.JobID
    LEFT JOIN _Open o ON s.JobID = o.JobID
    AND s.ListID = o.ListID
    AND s.BatchID = o.BatchID
    AND s.SubscriberID = o.SubscriberID
    AND o.IsUnique = 1
    LEFT JOIN _Click c ON s.JobID = c.JobID
    AND s.ListID = c.ListID
    AND s.BatchID = c.BatchID
    AND s.SubscriberID = c.SubscriberID
    AND c.IsUnique = 1
    LEFT JOIN _Bounce b ON s.JobID = b.JobID
    AND s.ListID = b.ListID
    AND s.BatchID = b.BatchID
    AND s.SubscriberID = b.SubscriberID
    AND b.IsUnique = 1
    LEFT JOIN _Unsubscribe u ON s.JobID = u.JobID
    AND s.ListID = u.ListID
    AND s.BatchID = u.BatchID
    AND s.SubscriberID = u.SubscriberID
    AND u.IsUnique = 1
    LEFT JOIN (
        SELECT
            jobid,
            ListID,
            BatchID,
            subscriberid,
            COUNT(subscriberid) AS Clicks
        FROM
            _click
        GROUP BY
            subscriberid,
            jobid,
            ListID,
            BatchID
    ) cl ON s.JobID = cl.JobID
    AND s.ListID = cl.ListID
    AND s.BatchID = cl.BatchID
    AND s.SubscriberID = cl.SubscriberID
    LEFT JOIN (
        SELECT DISTINCT
            jobid,
            ListID,
            BatchID,
            subscriberid,
            COUNT(DISTINCT url) AS URLs
        FROM
            _click
        GROUP BY
            subscriberid,
            jobid,
            ListID,
            BatchID
    ) url ON s.JobID = url.JobID
    AND s.ListID = url.ListID
    AND s.BatchID = url.BatchID
    AND s.SubscriberID = url.SubscriberID
    LEFT JOIN (
        SELECT
            jobid,
            ListID,
            BatchID,
            subscriberid,
            COUNT(subscriberid) AS Opens
        FROM
            _open
        GROUP BY
            subscriberid,
            jobid,
            ListID,
            BatchID
    ) op ON s.JobID = op.JobID
    AND s.ListID = op.ListID
    AND s.BatchID = op.BatchID
    AND s.SubscriberID = op.SubscriberID
    LEFT JOIN _ListSubscribers ls ON s.SubscriberID = ls.SubscriberID
WHERE
    j.AccountID = '100010094'
