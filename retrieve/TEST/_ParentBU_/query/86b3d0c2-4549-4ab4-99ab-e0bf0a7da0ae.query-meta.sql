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
    JB.Name AS JBName,
    /*JB.Status as JBStatus,*/
    JB.CRM_ID AS JB_CRMID,
    JB.Hospital AS JB_Site,
    JB.EPID AS EnterpriseID
FROM
    Contact_Salesforce AS Contacts
    INNER JOIN AMPFM_List JB ON Contacts.prm_epid__c = JB.EPID
    LEFT JOIN Facilities__c_Salesforce Facility ON Contacts.prm_primaryfacility__c = Facility.Id
    LEFT JOIN _ListSubscribers AllSubscribers ON Contacts.Id = AllSubscribers.SubscriberKey
WHERE
    (JB.EPID = Contacts.prm_epid__c)
    AND (Contacts.ctca_newstage__c NOT LIKE 'Expired')
    AND (Contacts.Email IS NOT NULL)
    AND (Contacts.HasOptedOutOfEmail NOT LIKE '1')
