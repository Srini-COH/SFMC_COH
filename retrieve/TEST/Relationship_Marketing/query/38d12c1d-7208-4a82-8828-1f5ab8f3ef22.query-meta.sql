SELECT
    sent.SubscriberID AS [sent_SubscriberID],
    sent.SubscriberKey AS [sent_SubscriberKey],
    sent.EventDate AS [sent_EventDate],
    sent.JobID AS [sent_JobID],
    j.EmailID AS [j_EmailID],
    j.EmailName AS [j_EmailName],
    j.EmailSendDefinition AS [j_EmailSendDefinition],
    j.SendType AS [j_SendType],
    j.PickupTime AS [j_PickupTime],
    j.DeliveredTime AS [j_DeliveredTime],
    j.CreatedDate AS [j_CreatedDate],
    j.EventID AS [j_EventID],
    j.TriggeredSendCustomerKey AS [j_TriggeredSendCustomerKey ]
FROM
    _Sent sent
    JOIN _Job j ON sent.JobID = j.JobID
WHERE
    j.TriggeredSendCustomerKey = '34887'
    AND (sent.EventDate >= DATEADD(DAY, -14, GETDATE()))
