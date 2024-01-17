SELECT DISTINCT
    Contacts.Id AS ContactId,
    Contacts.FirstName AS FirstName,
    Contacts.LastName AS LastName,
    Contacts.Title AS Title,
    Contacts.Email AS Email,
    Account.Name AS Account,
    Contacts.Status__c AS ContactStatus,
    Contacts.HasOptedOutOfEmail AS HasOptedOutOfEmail,
    AllSubscribers.Status AS MCStatus,
    Attendees.CampaignName AS OJOHEvent,
    /* BEGIN Dynamically Populate Region of Training Site */
    CASE
        WHEN Attendees.Site = 'ATL' THEN 'SERMC'
        WHEN Attendees.Site = 'CHI' THEN 'MRMC'
        WHEN Attendees.Site = 'PHX' THEN 'WRMC'
    END AS Region,
    /* END Dynamically Populate Region of Training Site */
    /* BEGIN Dynamically Populate Sender Email of Training Site */
    CASE
        WHEN Attendees.Site = 'ATL' THEN 'Chip.Gordon@ctca-hope.com'
        WHEN Attendees.Site = 'CHI' THEN 'Carl.Williamson@ctca-hope.com'
        WHEN Attendees.Site = 'PHX' THEN 'Jeffrey.Paparone@ctca-hope.com'
    END AS SenderAddress,
    /* END Dynamically Populate Sender Email of Training Site */
    /* BEGIN creation of name for salutation */
    CASE
        WHEN Contacts.Title IS NULL THEN Contacts.FirstName
        WHEN Contacts.Title IS NOT NULL THEN (CONCAT(Contacts.Title, ' ', Contacts.LastName))
    END AS GreetingName
    /* END creation of name for salutation */
FROM
    ENT.Contact_Salesforce AS Contacts
    INNER JOIN ENT.OJOHTargeting_OnboardingCampaign Attendees ON Contacts.Id = Attendees.ContactID
    LEFT JOIN ENT.Account_Salesforce Account ON Contacts.AccountId = Account.Id
    LEFT JOIN ENT._ListSubscribers AllSubscribers ON Contacts.Id = AllSubscribers.SubscriberKey
WHERE
    (Attendees.ContactID = Contacts.ID)
    AND (Contacts.Email IS NOT NULL)
    AND (Contacts.Status__c NOT LIKE 'Inactive')
    AND (Contacts.HasOptedOutOfEmail NOT LIKE '1')
    AND (Contacts.RecordTypeId = '01215000001UW7dAAG') /*this is the ID for the OJOH record type*/
