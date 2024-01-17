SELECT DISTINCT
    Contacts.Id AS ContactId,
    Contacts.FirstName AS FirstName,
    Contacts.LastName AS LastName,
    Contacts.Email AS Email,
    Facility.Name AS Facility,
    Contacts.ctca_iscancerfighter__c AS CFStatus,
    Contacts.[Receive_valuable_info_from_CF__c] AS CFReceiveInfoPermission,
    Contacts.ctca_newstage__c AS ContactStatus,
    Contacts.HasOptedOutOfEmail AS HasOptedOutOfEmail,
    AllSubscribers.Status AS MCStatus,
    Contacts.ctca_medicalrecordnumber__c AS MRN
FROM
    ENT.Contact_Salesforce AS Contacts
    INNER JOIN ENT.CL2020_Tulsa_InviteList Invitees ON Contacts.ctca_medicalrecordnumber__c = Invitees.MRN
    LEFT JOIN ENT.Facilities__c_Salesforce Facility ON Contacts.prm_primaryfacility__c = Facility.Id
    LEFT JOIN ENT._ListSubscribers AllSubscribers ON Contacts.Id = AllSubscribers.SubscriberKey
WHERE
    (
        Invitees.MRN = Contacts.ctca_medicalrecordnumber__c
    )
    AND (Contacts.Email IS NOT NULL)
    AND (Contacts.ctca_newstage__c NOT LIKE 'Expired')
    AND (Contacts.HasOptedOutOfEmail NOT LIKE '1')
