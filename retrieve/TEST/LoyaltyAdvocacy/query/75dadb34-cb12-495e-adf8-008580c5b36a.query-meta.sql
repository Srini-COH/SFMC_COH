SELECT DISTINCT
    o.Id AS 'SubscriberKey',
    o.Email AS 'EmailAddress',
    o.ctca_iscancerfighter__c,
    S.Delivered,
    S.Opens,
    S.Clicks,
    o.CF_Member_Created_Date__c
FROM
    Ent.Subscribers_No_Opens_Import s
    LEFT JOIN Ent.Contact_Salesforce o ON s.EmailAddress = o.Email
WHERE
    O.ctca_iscancerfighter__c IN ('CF', 'CFCN')
    AND O.[Receive_valuable_info_from_CF__c] = '1'
