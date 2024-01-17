SELECT DISTINCT
    Contacts.Id AS ContactId,
    Contacts.Email AS EmailAddress,
    Contacts.CF_First_Name__c AS CF_First_Name__c,
    Contacts.CF_Last_Name__c AS LastName,
    Contacts.Affiliated_Facility__c AS CF_Facility,
    Contacts.How_were_you_affected_by_cancer__c AS ContactType,
    Contacts.ctca_iscancerfighter__c AS CancerFighterStatus,
    AllSubscribers.Status AS MCStatus
FROM
    ENT.Contact_Salesforce AS Contacts
    INNER JOIN CF_ContactID_Upload_for_Targeting TargetIDs ON Contacts.Id = TargetIDs.ContactID
    LEFT JOIN ENT._ListSubscribers AllSubscribers ON Contacts.Id = AllSubscribers.SubscriberKey
WHERE
    (
        Contacts.ctca_iscancerfighter__c IN ('CF', 'CFCN')
    )
    AND (
        Contacts.[Receive_valuable_info_from_CF__c] LIKE '1'
    )
    AND (Contacts.Email IS NOT NULL)
    AND (Contacts.ctca_newstage__c NOT LIKE 'Expired')
    AND (Contacts.[HasOptedOutOfEmail] NOT LIKE '1')
