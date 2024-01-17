SELECT
    se.JobID,
    se.SubscriberID,
    s.SubscriberKey,
    se.EventDate AS 'SentDate',
    s.EmailAddress,
    O.EventDate AS 'OpenDate'
FROM
    _Subscribers s
    LEFT JOIN _Sent se ON se.Subscriberid = s.Subscriberid
    LEFT JOIN _Open O ON se.SubscriberId = o.SubscriberID
    LEFT JOIN Contact_Salesforce c ON S.SubscriberId = c.Id
WHERE
    c.ctca_iscancerfighter__c IN ('CF', 'CFCN')
    AND se.EventDate <> NULL
    AND o.eventdate = NULL
    /*convert(date, getdate()) */
