SELECT DISTINCT
    Contacts.Id AS ContactId,
    Contacts.FirstName AS FirstName,
    Contacts.LastName AS LastName,
    Contacts.Email AS Email,
    /*Account.Name as Account,
    Contacts.Status__c as ContactStatus,*/
    Contacts.HasOptedOutOfEmail AS HasOptedOutOfEmail,
    AllSubscribers.Status AS MCStatus
FROM
    ENT.Contact_Salesforce AS Contacts
    INNER JOIN ENT.ForumTargeting_Tulsa Invitees ON Contacts.Email = Invitees.Email
    LEFT JOIN ENT.Account_Salesforce Account ON Contacts.AccountId = Account.Id
    LEFT JOIN ENT._ListSubscribers AllSubscribers ON Contacts.Id = AllSubscribers.SubscriberKey
WHERE
    (Invitees.Email = Contacts.Email)
    AND (
        (Contacts.Email = 'maggie.redmon@ctca-hope.com')
        OR (Contacts.Email = 'bassethound1030@gmail.com')
    )
    /*AND (Contacts.Status__c NOT LIKE 'Inactive')*/
    AND (Contacts.HasOptedOutOfEmail NOT LIKE '1')
    AND (Contacts.RecordTypeId = '01215000000X07bAAC') /*this is the ID for the Medical Staff record type*/
