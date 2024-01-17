SELECT
    unsub.AccountID,
    unsub.OYBAccountID,
    unsub.JobID,
    unsub.ListID,
    unsub.BatchID,
    unsub.SubscriberID,
    unsub.SubscriberKey,
    unsub.EventDate,
    unsub.IsUnique,
    unsub.Domain
FROM
    _Unsubscribe AS unsub
