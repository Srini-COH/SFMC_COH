SELECT DISTINCT
    s.SubscriberKey,
    s.JobID,
    s.BatchID,
    s.EventDate AS 'SendDate',
    c.Email AS "EmailAddress"
FROM
    [_sent] s
    LEFT JOIN [_open] o ON s.JobID = o.JobID
    LEFT JOIN ent.Contact_Salesforce c ON s.SubscriberKey = c.ID
WHERE
    (o.SubscriberID IS NULL)
    AND C.ctca_iscancerfighter__c IN ('CF', 'CFCN')
    AND s.JobId = '507284'
