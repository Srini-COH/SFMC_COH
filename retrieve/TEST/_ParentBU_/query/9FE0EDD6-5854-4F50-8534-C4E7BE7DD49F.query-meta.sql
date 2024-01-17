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
    ) AS TravelTasks,
    AllSubscribers.Status AS MCStatus,
    AllSubscribers.ListName AS MCListName,
    AllSubscribers.ListID AS MCListID,
    AllSubscribers.DateUnsubscribed AS MCDateUnsubscribed
FROM
    Announcement_Targeting_Upload List
    INNER JOIN Contact_Salesforce Contacts ON List.MRN = Contacts.ctca_medicalrecordnumber__c
    INNER JOIN Account_Salesforce Account ON Contacts.AccountId = Account.Id
    LEFT JOIN Facilities__c_Salesforce Facility ON Contacts.prm_primaryfacility__c = Facility.Id
    /*LEFT JOIN _ListSubscribers AllSubscribers ON Contacts.Id = AllSubscribers.SubscriberKey*/
    LEFT JOIN _ListSubscribers AllSubscribers ON (
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
    AND (
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
        ) != 0
    )
