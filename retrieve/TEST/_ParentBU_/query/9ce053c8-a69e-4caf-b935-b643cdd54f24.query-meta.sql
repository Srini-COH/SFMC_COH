SELECT DISTINCT
    Contacts.Id AS ContactId,
    Contacts.Email AS Email,
    Contacts.CF_Member_Created_Date__c AS CF_Member_Created_Date,
    AllSubscribers.Status AS MCStatus,
    AllSubscribers.ListName AS MCListName,
    AllSubscribers.ListID AS MCListID,
    AllSubscribers.DateUnsubscribed AS MCDateUnsubscribed
FROM
    Contact_Salesforce AS Contacts
    INNER JOIN _ListSubscribers AllSubscribers ON Contacts.Id = AllSubscribers.SubscriberKey
WHERE
    (
        Contacts.CF_Member_Created_Date__c <= DATEADD(MONTH, -6, GETDATE())
    )
    AND Contacts.ctca_iscancerfighter__c IN ('CF', 'CFCN')
    AND (Contacts.ctca_newstage__c NOT LIKE 'Expired')
    AND (Contacts.HasOptedOutOfEmail NOT LIKE '1')
    AND (
        Contacts.[Receive_valuable_info_from_CF__c] LIKE '1'
    )
    AND (Contacts.[Inactive_Member__c] NOT LIKE '1')
