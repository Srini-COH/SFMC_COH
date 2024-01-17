SELECT
    objReferral.Id AS ReferralId,
    objReferral.MR_Referral_Date__c AS ReferralDate,
    objContact.FirstName AS ReferringContactFirstName,
    objContact.LastName AS ReferringContactLastName,
    objContact.Email AS ReferringContactEmail,
    objContact.Id AS ContactID
FROM
    ENT.MR_Patient_Referral__c_Salesforce AS objReferral
    JOIN ENT.Contact_Salesforce objContact ON objReferral.MR_Referring_Physician__c = objContact.Id
WHERE
    objContact.Email IS NOT NULL
    AND objContact.FirstName NOT LIKE '%unk%'
    AND objContact.HasOptedOutOfEmail NOT LIKE '1'
    AND objContact.ctca_iscancerfighter__c IN ('CF', 'CFCN')
    AND (
        objReferral.MR_Referral_Type__c = 'Patient / Caregiver'
        OR objReferral.Referral_Source__c = 'Patient/Caregiver'
    )
    AND objReferral.MR_Referring_Physician__c IS NOT NULL
    AND ObjReferral.MR_Referral_Date__c >= DATEADD(DAY, -8, GETDATE())
    AND objReferral.Id NOT IN (
        SELECT
            ReferralId
        FROM
            ENT.[Referral_Thank_You_Email_LOG]
        WITH
            (nolock)
    )
