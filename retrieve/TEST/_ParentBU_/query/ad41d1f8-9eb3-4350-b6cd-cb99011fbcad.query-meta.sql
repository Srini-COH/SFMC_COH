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
    Contacts.ctca_medicalrecordnumber__c AS MRN,
    JB.Email AS JBEmailAddress,
    JB.FirstName AS JBFirstName,
    JB.LastName AS JBLastName,
    JB.Birthday AS JB_Birthday,
    Contacts.Birthdate AS CNet_Birthday,
    JB.Site AS JBSite
FROM
    Contact_Salesforce AS Contacts
    INNER JOIN COVID_Announcement_JB_List JB ON Contacts.ctca_medicalrecordnumber__c = JB.MRN
    LEFT JOIN Facilities__c_Salesforce Facility ON Contacts.prm_primaryfacility__c = Facility.Id
    LEFT JOIN _ListSubscribers AllSubscribers ON Contacts.Id = AllSubscribers.SubscriberKey
WHERE
    (JB.MRN = Contacts.ctca_medicalrecordnumber__c)
    AND (Contacts.ctca_newstage__c NOT LIKE 'Expired')
    AND (Contacts.Email IS NOT NULL)
    AND (Contacts.HasOptedOutOfEmail NOT LIKE '1')
