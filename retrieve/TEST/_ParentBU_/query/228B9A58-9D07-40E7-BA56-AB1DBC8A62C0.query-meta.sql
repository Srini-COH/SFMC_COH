SELECT DISTINCT
    Contacts.ctca_medicalrecordnumber__c AS MRN_CNet,
    List.MRN AS MRN_list,
    Contacts.FirstName AS FirstName_CNet,
    List.FirstName AS FirstName_list,
    Contacts.LastName AS LastName_CNet,
    List.LastName AS LastName_list,
    Contacts.Email AS Email_CNet,
    List.Email AS Email_list,
    List.VariableData AS VariableDataField,
    Facility.Name AS Facility_CNet,
    List.Site AS Facility_list,
    Contacts.prm_epid__c AS EPID_CNet,
    List.EPID AS EPID_list,
    Contacts.ctca_iscancerfighter__c AS CFStatus,
    Contacts.[Receive_valuable_info_from_CF__c] AS CFReceiveInfoPermission,
    Contacts.ctca_newstage__c AS ContactStatus,
    Account.Expired__c AS ExpiredFlag,
    /*ExpirationDate determined not reliable so removed - Account.Expiration_Date__pc as ExpirationDate,*/
    Contacts.HealthCloudGA__DeceasedDate__c AS DeceasedDate,
    Contacts.HasOptedOutOfEmail AS HasOptedOutOfEmail,
    Contacts.Id AS ContactId,
    Contacts.AccountId AS AccountID,
    AllSubscribers.Status AS MCStatus,
    AllSubscribers.ListName AS MCListName,
    AllSubscribers.ListID AS MCListID,
    AllSubscribers.DateUnsubscribed AS MCDateUnsubscribed,
    /*(SELECT Count(Id) FROM Travel_Task__c_Salesforce WHERE (Account.Id = Patient__c AND Status__c='Complete' AND RecordTypeId ='0124R000001Nt1VQAS')) as TravelTasks*/
    (
        SELECT
            COUNT(Id)
        FROM
            Travel_Task__c_Salesforce
        WHERE
            (
                Account.Id = Patient__c
                AND Status__c = 'Complete'
                AND RecordTypeId IN (
                    '0124R000001Nt1SQAS',
                    '0124R000001Nt1UQAS',
                    '0124R000001Nt1VQAS',
                    '0124R000001Nt1WQAS'
                )
            )
    ) AS TravelTasks
    /*
    Travel Task IDs:
    Air: 0124R000001Nt1SQAS
    Hotel: 0124R000001Nt1UQAS
    Mileage: 0124R000001Nt1VQAS
    Rail: 0124R000001Nt1WQAS
    Generic: 0124R000001Nt1TQAS
    */
FROM
    Announcement_Targeting_Upload_for_MRNmatch List
    LEFT JOIN Contact_Salesforce Contacts ON List.MRN = Contacts.ctca_medicalrecordnumber__c
    LEFT JOIN Account_Salesforce Account ON Contacts.AccountId = Account.Id
    LEFT JOIN Facilities__c_Salesforce Facility ON Contacts.prm_primaryfacility__c = Facility.Id
    /*LEFT JOIN _ListSubscribers AllSubscribers ON Contacts.Id = AllSubscribers.SubscriberKey*/
    LEFT JOIN _ListSubscribers AllSubscribers ON (
        Contacts.Id = AllSubscribers.SubscriberKey
        AND AllSubscribers.ListID = 24
    )
    /*WHERE
    (List.MRN = Contacts.ctca_medicalrecordnumber__c)
    AND (Contacts.Email IS NOT NULL)
    AND (Contacts.HasOptedOutOfEmail NOT LIKE '1')
    
    AND ((Contacts.ctca_newstage__c IS NULL) OR (Contacts.ctca_newstage__c NOT LIKE 'Expired'))
    AND (Account.Expired__c NOT LIKE '1')
    AND (Contacts.HealthCloudGA__DeceasedDate__c IS NULL)
    */
