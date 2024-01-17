SELECT
    TOP 1
WITH
    TIES j.[MR_Patient_Referral__c:Contact__r:Id] AS Created_Contact_ID,
    j.[MR_Patient_Referral__c:Id] AS Referral_ID,
    j.[MR_Patient_Referral__c:MR_Referring_Physician__r:Email] AS Physician_Email,
    j.[MR_Patient_Referral__c:MR_Referring_Physician__r:Id] AS Physician_Contact_ID,
    u.Id AS Physician_User_ID,
    j.[MR_Patient_Referral__c:MR_Referring_Physician__r:Status_Update_Communications__c] AS Physician_Status_Update_Communications__c,
    j.Date_Entry AS Date_Sent,
    j.[MR_Patient_Referral__c:MR_Referring_Physician__r:FirstName] AS Physician_First_Name,
    j.[MR_Patient_Referral__c:MR_Referring_Physician__r:LastName] AS Physician_Last_Name
FROM
    Referral_Submitted_Confirmation_Journey j
    INNER JOIN ENT.User_Salesforce u ON u.ContactId = j.[MR_Patient_Referral__c:MR_Referring_Physician__r:Id]
WHERE
    j.Date_Entry >= DATEADD(HOUR, -1, GETDATE())
    AND j.[MR_Patient_Referral__c:MR_Referring_Physician__r:Email] != j.[MR_Patient_Referral__c:CreatedBy:Email]
    AND j.[MR_Patient_Referral__c:MR_Referring_Physician__r:Status_Update_Communications__c] = 'Opt in'
ORDER BY
    ROW_NUMBER() OVER (
        PARTITION BY
            j.[MR_Patient_Referral__c:MR_Referring_Physician__r:Email]
        ORDER BY
            NEWID()
    )
