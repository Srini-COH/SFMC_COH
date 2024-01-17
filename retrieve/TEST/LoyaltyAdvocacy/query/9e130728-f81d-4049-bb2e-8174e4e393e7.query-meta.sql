SELECT DISTINCT
    Contacts.ctca_medicalrecordnumber__c AS MRN_CNet,
    Invitees.MRN AS MRN_list,
    Contacts.FirstName AS FirstName_CNet,
    Invitees.FirstName AS FirstName_list,
    Contacts.LastName AS LastName_CNet,
    Invitees.LastName AS LastName_list,
    Contacts.Email AS Email_CNet,
    Invitees.Email AS Email_list,
    Facility.Name AS Facility_CNet,
    Invitees.Site AS Facility_list,
    Contacts.prm_epid__c AS EPID_CNet,
    Invitees.EPID AS EPID_list,
    Contacts.ctca_iscancerfighter__c AS CFStatus,
    Contacts.[Receive_valuable_info_from_CF__c] AS CFReceiveInfoPermission,
    Contacts.ctca_newstage__c AS ContactStatus,
    Contacts.HasOptedOutOfEmail AS HasOptedOutOfEmail,
    Contacts.Id AS ContactId,
    AllSubscribers.Status AS MCStatus,
    AllSubscribers.ListName AS MCListName,
    AllSubscribers.ListID AS MCListID,
    AllSubscribers.DateUnsubscribed AS MCDateUnsubscribed
FROM
    ENT.CL_Upload_for_EPID_Match Invitees
    LEFT JOIN ENT.Contact_Salesforce Contacts ON Invitees.EPID = Contacts.prm_epid__c
    LEFT JOIN ENT.Facilities__c_Salesforce Facility ON Contacts.prm_primaryfacility__c = Facility.Id
    /*LEFT JOIN ENT._ListSubscribers AllSubscribers ON Contacts.Id = AllSubscribers.SubscriberKey*/
    LEFT JOIN ENT._ListSubscribers AllSubscribers ON (
        Contacts.Id = AllSubscribers.SubscriberKey
        AND AllSubscribers.ListID = 24
    )
    /*WHERE
    (Invitees.MRN = Contacts.ctca_medicalrecordnumber__c)
    AND (Contacts.Email IS NOT NULL)
    
    AND (Contacts.ctca_newstage__c NOT LIKE 'Expired')
    AND (Contacts.HasOptedOutOfEmail NOT LIKE '1')
    */
