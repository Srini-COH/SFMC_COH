SELECT
    JobID,
    JobType,
    JobStatus,
    EmailID,
    FromEmail,
    SendClassification,
    SendClassificationType,
    EmailSendDefinition,
    TriggererSendDefinitionObjectID
FROM
    _Job
WHERE
    DeliveredTime >= DATEADD(hh, -72, GETDATE())
    OR CreatedDate >= DATEADD(hh, -72, GETDATE())
    OR ModifiedDate >= DATEADD(hh, -72, GETDATE())
