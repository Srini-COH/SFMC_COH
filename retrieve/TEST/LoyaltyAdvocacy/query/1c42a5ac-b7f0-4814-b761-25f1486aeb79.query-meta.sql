SELECT
    job.JobID,
    job.EmailID,
    job.EmailName,
    sent.SubscriberKey,
    sent.EventDate,
    objContact.Email AS EmailAddress
FROM
    _Sent sent
    JOIN _Job job ON job.JobID = sent.JobId
    JOIN ENT.Contact_Salesforce objContact ON sent.SubscriberKey = objContact.Id
WHERE
    job.EmailID IN ('13114', '11714')
