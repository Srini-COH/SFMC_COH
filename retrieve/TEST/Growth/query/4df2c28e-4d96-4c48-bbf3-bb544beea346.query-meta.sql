SELECT
    Unsubs.JobID,
    Unsubs.ListID,
    Unsubs.SubscriberKey,
    Unsubs.EventDate,
    Job.FromEmail,
    Job.EmailName,
    Job.SendClassification
FROM
    _Unsubscribe Unsubs
    INNER JOIN _Job Job ON Unsubs.JobID = Job.JobID
WHERE
    Job.SendClassification = 355
