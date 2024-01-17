SELECT
    complaint.AccountID,
    complaint.OYBAccountID,
    complaint.JobID,
    complaint.ListID,
    complaint.BatchID,
    complaint.SubscriberID,
    complaint.SubscriberKey,
    complaint.EventDate,
    complaint.IsUnique,
    complaint.Domain
FROM
    _Complaint AS complaint
