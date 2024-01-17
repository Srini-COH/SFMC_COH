SELECT DISTINCT
    Account.EPIC_medicalrecordnumber__c AS MRN_CNet,
    List.MRN AS MRN_list,
    Contacts.FirstName AS FirstName_CNet,
    List.FirstName AS FirstName_list,
    Contacts.LastName AS LastName_CNet,
    List.LastName AS LastName_list,
    Contacts.Email AS Email_CNet,
    List.EMAIL AS Email_list,
    List.VariableData AS VariableDataField,
    Facility.Name AS Facility_CNet,
    List.PRIMARY_LOCATION AS Facility_list,
    List.LAST_APPT_DTTM AS LastApptDate,
    List.LAST_APPT_LOCATION AS LastApptLocation,
    List.NEXT_APPT_DTTM AS NextApptDate,
    List.NEXT_APPT_LOCATION AS NextApptLocation,
    /*Contacts.prm_epid__c as EPID_CNet,
    List.EPID as EPID_list,*/
    Contacts.ctca_iscancerfighter__c AS CFStatus,
    Contacts.[Receive_valuable_info_from_CF__c] AS CFReceiveInfoPermission,
    Contacts.ctca_newstage__c AS ContactStatus,
    Account.Expired__c AS ExpiredFlag,
    Contacts.HealthCloudGA__DeceasedDate__c AS DeceasedDate,
    Contacts.HasOptedOutOfEmail AS HasOptedOutOfEmail,
    Contacts.Id AS ContactId,
    Contacts.AccountId AS AccountID,
    AllSubscribers.Status AS MCStatus,
    AllSubscribers.ListName AS MCListName,
    AllSubscribers.ListID AS MCListID,
    AllSubscribers.DateUnsubscribed AS MCDateUnsubscribed
FROM
    ENT.Imported_List_EpicMRN_for_Targeting_PtOfferings List
    LEFT JOIN ENT.Account_Salesforce Account ON List.MRN = Account.EPIC_medicalrecordnumber__c
    LEFT JOIN ENT.Contact_Salesforce Contacts ON Contacts.AccountId = Account.Id
    LEFT JOIN ENT._ListSubscribers AllSubscribers ON (
        Contacts.Id = AllSubscribers.SubscriberKey
        AND AllSubscribers.ListID = 24
    )
    LEFT JOIN ENT.Facilities__c_Salesforce Facility ON Contacts.prm_primaryfacility__c = Facility.Id
    /*WHERE
    (List.MRN = Account.EPIC_medicalrecordnumber__c)
    AND (Contacts.Email IS NOT NULL)
    AND (Contacts.HasOptedOutOfEmail NOT LIKE '1')
    
    AND ((Contacts.ctca_newstage__c IS NULL) OR (Contacts.ctca_newstage__c NOT LIKE 'Expired'))
    AND (Account.Expired__c NOT LIKE '1')
    AND (Contacts.HealthCloudGA__DeceasedDate__c IS NULL)
    */
