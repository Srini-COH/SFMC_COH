SELECT
    Contacts.ctca_medicalrecordnumber__c AS MRN_CNet,
    List.Original_MRN AS Original_MRN,
    List.New_MRN AS New_MRN,
    Contacts.FirstName AS FirstName_CNet,
    Contacts.LastName AS LastName_CNet,
    List.Patient_Name AS PtName_list,
    Contacts.Email AS Email_CNet,
    Facility.Name AS Facility_CNet,
    List.New_Facility AS Facility_list,
    Contacts.Id AS ContactId,
    List.ContactID AS ContactID_list,
    Contacts.prm_epid__c AS EPID_CNet,
    Contacts.ctca_iscancerfighter__c AS CFStatus,
    Contacts.[Receive_valuable_info_from_CF__c] AS CFReceiveInfoPermission,
    Contacts.ctca_newstage__c AS ContactStatus,
    Contacts.HasOptedOutOfEmail AS HasOptedOutOfEmail,
    AllSubscribers.Status AS MCStatus,
    AllSubscribers.ListName AS MCListName,
    AllSubscribers.ListID AS MCListID,
    AllSubscribers.DateUnsubscribed AS MCDateUnsubscribed
FROM
    TransferPt_MRN_Upload_for_Targeting List
    LEFT JOIN ENT.Contact_Salesforce Contacts ON List.New_MRN = Contacts.ctca_medicalrecordnumber__c
    LEFT JOIN ENT.Facilities__c_Salesforce Facility ON Contacts.prm_primaryfacility__c = Facility.Id
    /*LEFT JOIN ENT._ListSubscribers AllSubscribers ON Contacts.Id = AllSubscribers.SubscriberKey*/
    LEFT JOIN ENT._ListSubscribers AllSubscribers ON (
        Contacts.Id = AllSubscribers.SubscriberKey
        AND AllSubscribers.ListID = 4090
    )
    /*WHERE
    (List.MRN = Contacts.ctca_medicalrecordnumber__c)
    AND (Contacts.Email IS NOT NULL)
    
    AND (Contacts.ctca_newstage__c NOT LIKE 'Expired')
    AND (Contacts.HasOptedOutOfEmail NOT LIKE '1')
    */
