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
    AllSubscribers.Status AS MCStatus,
    AllSubscribers.ListName AS MCListName,
    AllSubscribers.ListID AS MCListID,
    AllSubscribers.DateUnsubscribed AS MCDateUnsubscribed,
    FV.ctca_apptdate__c AS ApptDate,
    FV.ctca_appointmentresults__c AS ApptResults,
    (FV.ctca_1sttxdate__c) AS FirstTxDate,
    FV.Appointment_Type__c AS ApptType
FROM
    Announcement_Targeting_Upload List
    INNER JOIN Contact_Salesforce Contacts ON List.MRN = Contacts.ctca_medicalrecordnumber__c
    LEFT JOIN Facilities__c_Salesforce Facility ON Contacts.prm_primaryfacility__c = Facility.Id
    /*LEFT JOIN _ListSubscribers AllSubscribers ON Contacts.Id = AllSubscribers.SubscriberKey*/
    LEFT JOIN _ListSubscribers AllSubscribers ON (
        Contacts.Id = AllSubscribers.SubscriberKey
        AND AllSubscribers.ListID = 24
    )
    LEFT JOIN (
        SELECT
            TOP 1
        WITH
            TIES subFV.ctca_contactid__c,
            subFV.ctca_apptstatus__c,
            subFV.ctca_apptdate__c,
            subFV.ctca_appointmentresults__c,
            (subFV.ctca_1sttxdate__c),
            subFV.ctca_scheduledon__c,
            subFV.Appointment_Type__c
        FROM
            [Facility_Visits__c_Salesforce] subFV
        WHERE
            subFV.ctca_apptstatus__c = 'Scheduled'
        ORDER BY
            ROW_NUMBER() OVER (
                PARTITION BY
                    subFV.ctca_contactid__c
                ORDER BY
                    subFV.ctca_scheduledon__c DESC
            )
    ) FV ON Contacts.Id = FV.ctca_contactid__c
WHERE
    (Contacts.Email IS NOT NULL)
    AND Contacts.Email NOT LIKE '%nopatientemail%'
    AND Contacts.Email NOT LIKE '%noemail%'
    AND Contacts.Email NOT LIKE '%none@%'
    AND (
        (Contacts.ctca_newstage__c IS NULL)
        OR (
            Contacts.ctca_newstage__c NOT IN ('Expired', 'Hospice')
        )
    )
    AND (Contacts.HasOptedOutOfEmail NOT LIKE '1')
