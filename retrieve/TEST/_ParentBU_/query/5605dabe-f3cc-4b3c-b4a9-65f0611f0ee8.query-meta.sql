SELECT DISTINCT
    Contacts.ctca_medicalrecordnumber__c AS MRN,
    Contacts.FirstName AS FirstName_CNet,
    List.FirstName AS FirstName_list,
    Contacts.LastName AS LastName_CNet,
    List.LastName AS LastName_list,
    Contacts.Email AS Email_CNet,
    List.Email AS Email_list,
    Facility.Name AS Facility_CNet,
    List.Site AS Facility_list,
    Contacts.prm_epid__c AS EPID_CNet,
    /*List.EPID as EPID_list,*/
    Contacts.ctca_iscancerfighter__c AS CFStatus,
    Contacts.[Receive_valuable_info_from_CF__c] AS CFReceiveInfoPermission,
    Contacts.ctca_newstage__c AS ContactStatus,
    Contacts.HasOptedOutOfEmail AS HasOptedOutOfEmail,
    Contacts.Id AS ContactId,
    Contacts.AccountId AS AccountID,
    List.Additional_Info1 AS Additional_Info1,
    AllSubscribers.Status AS MCStatus,
    AllSubscribers.ListName AS MCListName,
    AllSubscribers.ListID AS MCListID,
    AllSubscribers.DateUnsubscribed AS MCDateUnsubscribed
FROM
    Announcement_Upload_for_ContactIDMatch List
    LEFT JOIN Contact_Salesforce Contacts ON List.ContactID = Contacts.Id
    LEFT JOIN Facilities__c_Salesforce Facility ON Contacts.prm_primaryfacility__c = Facility.Id
    /*LEFT JOIN _ListSubscribers AllSubscribers ON Contacts.Id = AllSubscribers.SubscriberKey*/
    LEFT JOIN _ListSubscribers AllSubscribers ON (
        Contacts.Id = AllSubscribers.SubscriberKey
        AND AllSubscribers.ListID = 24
    )
    /*WHERE
    (List.MRN = Contacts.ctca_medicalrecordnumber__c)
    AND (Contacts.Email IS NOT NULL)
    
    AND (Contacts.ctca_newstage__c NOT LIKE 'Expired')
    AND (Contacts.HasOptedOutOfEmail NOT LIKE '1')
    */
