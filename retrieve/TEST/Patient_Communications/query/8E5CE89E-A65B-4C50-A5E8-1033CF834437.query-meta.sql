SELECT DISTINCT
    Account.EPIC_medicalrecordnumber__c AS MRN_CNet,
    List.MRN AS MRN_list,
    Contacts.ctca_medicalrecordnumber__c AS CTCAMRN_CNet,
    Contacts.FirstName AS FirstName_CNet,
    List.FirstName AS FirstName_list,
    Contacts.LastName AS LastName_CNet,
    List.LastName AS LastName_list,
    Contacts.Email AS Email,
    List.VariableData AS VariableDataField,
    Facility.Name AS Facility_CNet,
    List.PRIMARY_LOCATION AS Facility_list,
    List.LAST_APPT_DTTM AS LastApptDate,
    List.LAST_APPT_LOCATION AS LastApptLocation,
    List.NEXT_APPT_DTTM AS NextApptDate,
    List.NEXT_APPT_LOCATION AS NextApptLocation,
    Contacts.prm_epid__c AS EPID_CNet,
    List.EPID AS EPID_list,
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
    ENT.Imported_List_EPID_for_Targeting_PtOfferings List
    LEFT JOIN ENT.Contact_Salesforce Contacts ON List.EPID = Contacts.prm_epid__c
    LEFT JOIN ENT.Account_Salesforce Account ON Contacts.AccountId = Account.Id
    LEFT JOIN ENT.Facilities__c_Salesforce Facility ON Contacts.prm_primaryfacility__c = Facility.Id
    LEFT JOIN ENT._ListSubscribers AllSubscribers ON (
        Contacts.Id = AllSubscribers.SubscriberKey
        AND AllSubscribers.ListID = 24
    )
WHERE
    List.EPID IS NOT NULL
    AND (Contacts.Email IS NOT NULL)
    AND Contacts.Email NOT LIKE '%nopatientemail%'
    AND Contacts.Email NOT LIKE '%noemail%'
    AND Contacts.Email NOT LIKE '%unknown%'
    AND Contacts.Email NOT LIKE '%none@%'
    AND Contacts.Email NOT LIKE '%none.com%'
    AND Contacts.Email NOT LIKE '%optout%'
    AND Contacts.Email NOT LIKE '%no@email.com%'
    AND Contacts.Email NOT LIKE '%decline@%'
    AND Contacts.Email NOT LIKE '%declined@%'
    AND Contacts.Email NOT LIKE '%@no_email.com%'
    AND Contacts.Email NOT LIKE 'na@%'
    AND (Contacts.HasOptedOutOfEmail NOT LIKE '1')
    AND (
        (AllSubscribers.Status IS NULL)
        OR (AllSubscribers.Status = 'active')
    )
    AND (
        (Contacts.ctca_newstage__c IS NULL)
        OR (Contacts.ctca_newstage__c NOT LIKE 'Expired')
    )
    AND (Account.Expired__c NOT LIKE '1')
    AND (Contacts.HealthCloudGA__DeceasedDate__c IS NULL)
    /*  AND (List.MRN = Account.EPIC_medicalrecordnumber__c)*/