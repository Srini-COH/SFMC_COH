SELECT DISTINCT
    List.MRN AS MRN,
    List.EMAIL AS Email,
    List.VariableData AS VariableDataField,
    Facility.Name AS Facility_CNet,
    List.PRIMARY_LOCATION AS Facility_list,
    List.LAST_APPT_DTTM AS LastApptDate,
    List.LAST_APPT_LOCATION AS LastApptLocation,
    List.NEXT_APPT_DTTM AS NextApptDate,
    List.NEXT_APPT_LOCATION AS NextApptLocation,
    Contacts.HasOptedOutOfEmail AS HasOptedOutOfEmail,
    Contacts.ctca_newstage__c AS ContactStatus,
    Contacts.Id AS ContactId,
    AllSubscribers.Status AS MCStatus,
    AllSubscribers.ListName AS MCListName,
    AllSubscribers.ListID AS MCListID,
    AllSubscribers.DateUnsubscribed AS MCDateUnsubscribed
FROM
    ENT.Imported_List_for_Targeting List
    INNER JOIN ENT.Account_Salesforce Account ON List.MRN = Account.EPIC_medicalrecordnumber__c
    LEFT JOIN ENT.Contact_Salesforce Contacts ON Account.Id = Contacts.AccountId
    LEFT JOIN ENT.Facilities__c_Salesforce Facility ON Contacts.prm_primaryfacility__c = Facility.Id
    LEFT JOIN ENT._ListSubscribers AllSubscribers ON (
        Contacts.Id = AllSubscribers.SubscriberKey
        AND AllSubscribers.ListID = 24
    )
WHERE
    (List.EMAIL IS NOT NULL)
    AND List.EMAIL NOT LIKE '%nopatientemail%'
    AND List.EMAIL NOT LIKE '%noemail%'
    AND List.EMAIL NOT LIKE '%none@%'
    AND List.EMAIL NOT LIKE '%none.com%'
    AND List.EMAIL NOT LIKE '%optout%'
    AND List.EMAIL NOT LIKE '%no@email.com%'
    AND List.EMAIL NOT LIKE '%decline@%'
    AND List.EMAIL NOT LIKE '%declined@%'
    AND List.EMAIL NOT LIKE '%@no_email.com%'
    AND (
        (Contacts.ctca_newstage__c IS NULL)
        OR (Contacts.ctca_newstage__c NOT LIKE 'Expired')
    )
    AND (Account.Expired__c NOT LIKE '1')
    AND (Contacts.HealthCloudGA__DeceasedDate__c IS NULL)
    AND (Contacts.HasOptedOutOfEmail NOT LIKE '1')
