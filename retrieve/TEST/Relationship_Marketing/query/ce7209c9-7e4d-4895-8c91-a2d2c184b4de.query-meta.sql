SELECT DISTINCT
    Target.EPID AS EPID,
    Target.FullName AS FullName,
    Target.Email AS PortalEmail,
    Target.LastLoginDate AS LastLoginDate,
    Contacts.Id AS ContactId,
    Contacts.Email AS CNetEmail,
    /*Contacts.CF_First_Name__c as CF_First_Name__c,
    Contacts.CF_Last_Name__c as CF_Last_Name__c,
    Contacts.Affiliated_Facility__c as CF_Facility,
    Contacts.How_were_you_affected_by_cancer__c AS ContactType,
    Contacts.ctca_iscancerfighter__c as CancerFighterStatus,
    Contacts.[Receive_valuable_info_from_CF__c] as CFReceiveValuableInfo,*/
    AllSubscribers.Status AS MCStatus,
    Contacts.ctca_newstage__c AS ContactStatus,
    Contacts.[HasOptedOutOfEmail] AS EmailOptOut,
    Contacts.Contact_Type__c AS ContactType,
    Contacts.FirstName AS FirstName,
    Contacts.LastName AS LastName,
    AllSubscribers.ListName AS MCListName,
    AllSubscribers.ListID AS MCListID,
    AllSubscribers.DateUnsubscribed AS DateUnsubscribed,
    Contacts.ctca_medicalrecordnumber__c AS MRN
FROM
    ENT.myCTCA_Portal_Users_Upload Target
    LEFT JOIN ENT.Contact_Salesforce Contacts ON Target.EPID = Contacts.prm_epid__c
    LEFT JOIN ENT._ListSubscribers AllSubscribers ON Contacts.Id = AllSubscribers.SubscriberKey
WHERE
    (
        (ALLSubscribers.ListID IS NULL)
        OR (ALLSubscribers.ListID = '24')
    )
    /*WHERE
    (Contacts.ctca_newstage__c NOT LIKE 'Expired')
    AND (Contacts.[HasOptedOutOfEmail] NOT LIKE '1')
    */
