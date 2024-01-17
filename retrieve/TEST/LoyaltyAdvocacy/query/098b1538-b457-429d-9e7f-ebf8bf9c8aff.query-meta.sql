SELECT DISTINCT
    Contacts.Id AS ContactId,
    Contacts.FirstName AS FirstName,
    Contacts.LastName AS LastName,
    Contacts.Email AS Email,
    Contacts.ctca_newstage__c AS ContactStatus,
    Contacts.ctca_iscancerfighter__c AS CFStatus,
    Contacts.[Receive_valuable_info_from_CF__c] AS CFReceiveInfoPermission,
    Contacts.CF_Member_Created_Date__c AS CFMemberCreatedDate,
    Contacts.How_did_you_hear_about_CF__c AS HowDidYouHearAboutCF,
    Contacts.Affiliated_Facility__c AS Affiliated_Facility,
    Contacts.HasOptedOutOfEmail AS HasOptedOutOfEmail,
    AllSubscribers.Status AS SubscriptionStatus,
    Contacts.Has_User_Account__c AS UserEnabled
FROM
    ENT.Contact_Salesforce AS Contacts
    LEFT JOIN ENT.Account_Salesforce Account ON Contacts.AccountId = Account.Id
    LEFT JOIN ENT._ListSubscribers AllSubscribers ON (
        Contacts.Id = AllSubscribers.SubscriberKey
        AND AllSubscribers.ListID = 24
    )
WHERE
    Contacts.ctca_iscancerfighter__c = 'CF'
    AND Contacts.How_did_you_hear_about_CF__c = 'Auto-enrolled as patient benefit'
    AND (
        (
            Contacts.CF_Member_Created_Date__c >= '2023-08-22'
        )
        AND (
            Contacts.CF_Member_Created_Date__c >= DATEADD(DAY, -7, GETDATE())
        )
    )
    AND (Contacts.Email IS NOT NULL)
    AND (
        Contacts.[Receive_valuable_info_from_CF__c] LIKE '1'
    )
    AND (
        (Contacts.ctca_newstage__c IS NULL)
        OR (Contacts.ctca_newstage__c NOT LIKE 'Expired')
    )
    AND (Account.Expired__c NOT LIKE '1')
    AND (Contacts.HealthCloudGA__DeceasedDate__c IS NULL)
    AND (Contacts.HasOptedOutOfEmail NOT LIKE '1')
