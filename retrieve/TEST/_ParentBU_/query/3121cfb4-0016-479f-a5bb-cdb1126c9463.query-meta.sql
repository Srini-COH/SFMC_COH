/* UE_Growth_All_DV_Sends */
SELECT
    s.SubscriberKey,
    ls.EmailAddress,
    j.EmailName,
    j.EmailSubject,
    j.FromName,
    j.FromEmail,
    s.EventDate AS SentDate,
    o.EventDate AS OpenDate,
    c.EventDate AS ClickDate,
    b.EventDate AS BouncedDate,
    b.BounceCategory,
    u.EventDate AS UnsubscribedDate,
    j.AccountID AS MID,
    ls.CreatedDate AS AllSubscribersCreatedDate
FROM
    _Sent s
    LEFT JOIN DV_Job_Growth j ON s.JobID = j.JobID
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
    LEFT JOIN _ListSubscribers ls ON s.SubscriberID = ls.SubscriberID
WHERE
    ls.ListID = 24
    AND j.AccountID = '100010091' /*Growth MID*/
