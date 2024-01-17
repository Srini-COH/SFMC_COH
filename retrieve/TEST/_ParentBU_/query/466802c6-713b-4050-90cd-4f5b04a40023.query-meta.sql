SELECT
    b.JobID,
    b.SubscriberID,
    s.SubscriberKey,
    b.EventDate,
    b.Domain,
    b.BounceCategoryID,
    b.BounceCategory,
    b.BounceSubcategoryID,
    b.BounceSubcategory,
    b.BounceTypeID,
    b.BounceType,
    b.SMTPBounceReason,
    b.SMTPMessage,
    b.SMTPCode,
    b.TriggererSendDefinitionObjectID,
    b.TriggeredSendCustomerKey,
    s.EmailAddress,
    s.BounceCount,
    s.DateUndeliverable,
    s.DateUnsubscribed,
    s.Status,
    j.EmailID,
    j.FromName,
    j.FromEmail,
    j.EmailName,
    j.SalesForceTotalSubscriberCount,
    j.SendType,
    j.category
FROM
    _bounce b
    LEFT JOIN _Subscribers s ON b.Subscriberid = s.Subscriberid
    LEFT JOIN _Job j ON b.jobid = j.jobid
WHERE
    s.BounceCount > 3
    AND b.BounceCategory = 'Hard Bounce'
