SELECT
    List.MRN AS MRN_list,
    Contacts.ctca_medicalrecordnumber__c AS MRN_CNet,
    Contacts.FirstName AS FirstName,
    Contacts.LastName AS LastName,
    Contacts.Email AS Email,
    Facility.Name AS Facility_CNet,
    List.Site AS Facility_list,
    Contacts.prm_epid__c AS EPID_CNet,
    List.EPID AS EPID_list,
    Contacts.ctca_iscancerfighter__c AS CFStatus,
    Contacts.[Receive_valuable_info_from_CF__c] AS CFReceiveInfoPermission,
    Contacts.ctca_newstage__c AS ContactStatus,
    Contacts.HasOptedOutOfEmail AS HasOptedOutOfEmail,
    Contacts.Id AS ContactId,
    U.Username AS Username,
    AllSubscribers.Status AS MCStatus,
    AllSubscribers.ListName AS MCListName,
    AllSubscribers.ListID AS MCListID,
    AllSubscribers.DateUnsubscribed AS MCDateUnsubscribed
FROM
    ENT.CL_Upload_for_EPID_Match List
    INNER JOIN ENT.Contact_Salesforce Contacts ON List.EPID = Contacts.prm_epid__c
    LEFT JOIN ENT.User_Salesforce U ON U.ContactId = Contacts.Id
    LEFT JOIN ENT.Facilities__c_Salesforce Facility ON Contacts.prm_primaryfacility__c = Facility.Id
    LEFT JOIN ENT._ListSubscribers AllSubscribers ON (
        Contacts.Id = AllSubscribers.SubscriberKey
        AND AllSubscribers.ListID = 24
    )
WHERE
    (Contacts.Email IS NOT NULL)
    AND Contacts.Email NOT LIKE '%nopatientemail%'
    AND Contacts.Email NOT LIKE '%noemail%'
    AND Contacts.Email NOT LIKE '%none@%'
    AND (
        (Contacts.ctca_newstage__c IS NULL)
        OR (Contacts.ctca_newstage__c NOT LIKE 'Expired')
    )
    AND (Contacts.HasOptedOutOfEmail NOT LIKE '1')
