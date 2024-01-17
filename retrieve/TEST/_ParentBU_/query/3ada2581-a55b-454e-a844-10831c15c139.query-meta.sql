SELECT
    c.SubscriberKey AS [LeadId],
    c.TriggererSendDefinitionObjectID AS [TriggeredSendObjectId],
    c.EventDate AS [EventDate]
FROM
    _Click c
    INNER JOIN _Job j ON j.JobID = c.JobID
WHERE
    j.EmailName = 'Email OptIn Test'
