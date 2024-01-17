SELECT DISTINCT
    s.SubscriberKey,
    s.JobID,
    S.SentDate,
    o.Email AS 'EmailAddress',
    o.ctca_iscancerfighter__c,
    Sub.Status
FROM
    Ent.No_Open_Join s
    LEFT JOIN Ent.Contact_Salesforce o ON s.SubscriberKey = o.Id
    LEFT JOIN _Subscribers sub ON S.SubscriberKey = Sub.Subscriberkey
WHERE
    O.ctca_iscancerfighter__c IN ('CF', 'CFCN')
    AND O.[Receive_valuable_info_from_CF__c] = '1'
    AND S.SentDate <= DATEADD(MONTH, -5, GETDATE())
