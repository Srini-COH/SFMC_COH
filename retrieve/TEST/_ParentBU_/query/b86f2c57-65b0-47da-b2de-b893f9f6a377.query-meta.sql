SELECT
    o.AccountID,
    o.OYBAccountID,
    o.JobID,
    o.ListID,
    o.BatchID,
    o.SubscriberID,
    o.SubscriberKey,
    o.EventDate,
    o.Domain,
    o.IsUnique,
    o.TriggererSendDefinitionObjectID,
    o.TriggeredSendCustomerKey
FROM
    _Open AS o
