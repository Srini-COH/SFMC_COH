SELECT
    sent.AccountID,
    sent.OYBAccountID,
    sent.JobID,
    sent.ListID,
    sent.BatchID,
    sent.SubscriberID,
    sent.SubscriberKey,
    sent.EventDate,
    sent.Domain,
    sent.TriggererSendDefinitionObjectID,
    sent.TriggeredSendCustomerKey
FROM
    _Sent AS sent
