SELECT
    click.AccountID,
    click.OYBAccountID,
    click.JobID,
    click.ListID,
    click.BatchID,
    click.SubscriberID,
    click.SubscriberKey,
    click.EventDate,
    click.Domain,
    click.URL,
    click.LinkName,
    click.LinkContent,
    click.IsUnique,
    click.TriggererSendDefinitionObjectID,
    click.TriggeredSendCustomerKey
FROM
    _Click AS click
