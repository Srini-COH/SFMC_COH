SELECT
    b.JobID,
    b.SubscriberID,
    s.SubscriberKey,
    b.EventDate,
    b.Domain,
    b.BounceCategoryID,
    b.BounceCategory,
    b.BounceSubcategoryID,
    BounceSubcategory,
    BounceTypeID,
    BounceType,
    SMTPBounceReason,
    SMTPMessage,
    SMTPCode,
    TriggererSendDefinitionObjectID,
    TriggeredSendCustomerKey,
    s.EmailAddress,
    s.BounceCount,
    s.DateUndeliverable,
    s.DateUnsubscribed,
    s.Status
FROM
    _bounce b
    LEFT JOIN _Subscribers s ON b.Subscriberid = s.Subscriberid
WHERE
    JobId = '477931'
