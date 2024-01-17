SELECT
    _Sent.JobID AS JobID,
    _Sent.SubscriberKey AS SubKey,
    _Sent.TriggererSendDefinitionObjectID AS TriggerSendID,
    _Job.EmailName AS EmailName
FROM
    _Sent
    INNER JOIN _Job ON _Sent.JobID = _Job.JobID
WHERE
    _Sent.TriggererSendDefinitionObjectID = 'ae5afaf2f2c847f8988ddc97f3e22dc5'
