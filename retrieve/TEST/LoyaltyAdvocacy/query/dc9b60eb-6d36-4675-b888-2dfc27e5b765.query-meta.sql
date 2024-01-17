SELECT
    TOP 1
WITH
    TIES r.Id AS ReferralId,
    r.Last_Updated_Date__c,
    r.Hard_Referral__c,
    r.MR_Referral_Status__c,
    u.ContactId AS UserContactId,
    u.Email,
    u.FFProfile_Name__c,
    u.Status_Update_Communications__c,
    u.Status_Update_Communications_Timestamp__c,
    c.FirstName,
    c.LastName,
    c.Contact_Type__c
FROM
    ENT.MR_Patient_Referral__c_Salesforce r
    INNER JOIN ENT.User_Salesforce u ON r.MR_Referring_Physician__c = u.ContactId
    OR r.CreatedById = u.Id
    INNER JOIN ENT.Contact_Salesforce c ON u.ContactId = c.Id
WHERE
    r.Hard_Referral__c = 1
    AND r.Last_Updated_Date__c >= DATEADD(DAY, -100, GETDATE())
    AND u.FFProfile_Name__c = 'Physician Community User'
    AND u.Status_Update_Communications__c = 'Opt in'
    AND u.Email IS NOT NULL
ORDER BY
    ROW_NUMBER() OVER (
        PARTITION BY
            u.Email
        ORDER BY
            NEWID()
    )
