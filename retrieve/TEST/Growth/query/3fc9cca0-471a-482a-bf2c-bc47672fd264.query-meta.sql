SELECT
    job.JobID,
    job.EmailID,
    job.AccountID,
    job.AccountUserID,
    job.FromName,
    job.FromEmail,
    job.SchedTime,
    job.PickupTime,
    job.DeliveredTime,
    job.EventID,
    job.IsMultipart,
    job.JobType,
    job.JobStatus,
    job.ModifiedBy,
    job.ModifiedDate,
    job.EmailName,
    job.EmailSubject,
    job.IsWrapped,
    job.TestEmailAddr,
    job.Category,
    job.BccEmail,
    job.OriginalSchedTime,
    job.CreatedDate,
    job.CharacterSet,
    job.IPAddress,
    job.SalesForceTotalSubscriberCount,
    job.SalesForceErrorSubscriberCount,
    job.SendType,
    job.DynamicEmailSubject,
    job.SuppressTracking,
    job.SendClassificationType,
    job.SendClassification,
    job.ResolveLinksWithCurrentData,
    job.EmailSendDefinition,
    job.DeduplicateByEmail,
    job.TriggererSendDefinitionObjectID,
    job.TriggeredSendCustomerKey
FROM
    _Job AS job
