SELECT DISTINCT
    Contacts.Id AS ContactId,
    Contacts.Email AS EmailAddress,
    Contacts.CF_First_Name__c AS CF_First_Name__c,
    Contacts.CF_Last_Name__c AS CF_Last_Name__c,
    Contacts.Affiliated_Facility__c AS CF_Facility,
    Contacts.How_were_you_affected_by_cancer__c AS ContactType,
    Contacts.ctca_iscancerfighter__c AS CancerFighterStatus,
    AllSubscribers.Status AS MCStatus,
    Contacts.CF_Member_Created_Date__c AS CF_Member_Created_Date,
    Contacts.[Receive_valuable_info_from_CF__c] AS CFEmailPermission
FROM
    ENT.Contact_Salesforce AS Contacts
    LEFT JOIN ENT.Account_Salesforce Account ON Contacts.AccountId = Account.Id
    LEFT JOIN ENT._ListSubscribers AllSubscribers ON Contacts.Id = AllSubscribers.SubscriberKey
WHERE
    (
        Contacts.CF_Member_Created_Date__c >= '2022-03-01'
    )
    AND (
        Contacts.CF_Member_Created_Date__c <= DATEADD(DAY, -12, GETDATE())
    )
    AND Contacts.How_were_you_affected_by_cancer__c = 'Patient'
    AND (
        (Contacts.Affiliated_Facility__c IS NOT NULL)
        AND (Contacts.Affiliated_Facility__c NOT LIKE 'Other')
    )
    AND (
        Contacts.ctca_iscancerfighter__c IN ('CF', 'CFCN')
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
    AND (Contacts.[HasOptedOutOfEmail] NOT LIKE '1')
    AND (Contacts.[Inactive_Member__c] NOT LIKE '1')
    AND AllSubscribers.Status = 'Active'
