SELECT DISTINCT
    objContact.Id AS ContactID,
    objContact.FirstName AS ReferringContactFirstName,
    objContact.LastName AS ReferringContactLastName,
    objContact.Email AS ReferringContactEmail,
    (
        SELECT
            COUNT(Id)
        FROM
            ENT.MR_Patient_Referral__c_Salesforce
        WHERE
            (
                objContact.Id = MR_Referring_Physician__c
                AND (
                    MR_Referral_Type__c = 'Patient / Caregiver'
                    OR Referral_Source__c = 'Patient/Caregiver'
                )
                AND MR_Referral_Date__c >= DATEADD(DAY, -8, GETDATE())
            )
    ) AS ReferralCount
FROM
    ENT.Contact_Salesforce objContact
    JOIN ENT.MR_Patient_Referral__c_Salesforce AS objReferral ON objReferral.MR_Referring_Physician__c = objContact.Id
WHERE
    objContact.Email IS NOT NULL
    AND objContact.FirstName NOT LIKE '%unk%'
    AND objContact.FirstName NOT LIKE '%delete%'
    AND objContact.HasOptedOutOfEmail NOT LIKE '1'
    AND objContact.[Receive_valuable_info_from_CF__c] LIKE '1'
    AND objContact.ctca_iscancerfighter__c IN ('CF', 'CFCN')
    AND (objContact.[Inactive_Member__c] NOT LIKE '1')
    AND ObjReferral.MR_Referral_Date__c >= DATEADD(DAY, -8, GETDATE())
    AND (
        objReferral.MR_Referral_Type__c = 'Patient / Caregiver'
        OR objReferral.Referral_Source__c = 'Patient/Caregiver'
    )
    AND objReferral.MR_Referring_Physician__c IS NOT NULL
    AND (
        (ObjReferral.Contact__c IS NOT NULL)
        OR (ObjReferral.Opportunity__c IS NOT NULL)
        OR (ObjReferral.Lead__c IS NOT NULL)
    )
    AND objReferral.Id NOT IN (
        SELECT
            ReferralId
        FROM
            ENT.[CF_Referral_ThankYou_Log]
        WITH
            (nolock)
    )
    /*AND CAST(ObjReferral.MR_Referral_Date__c AS Date) >= '2021-04-12'*/
