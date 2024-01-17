SELECT DISTINCT
    objReferral.Id AS ReferralId,
    objReferral.MR_Referral_Date__c AS ReferralDate,
    objReferral.CreatedDate AS ReferralCreated,
    ObjReferral.MR_Referral_Type__c AS ReferralType,
    objReferral.Referral_Source__c AS ReferralSource,
    ObjReferral.Referring_Contact__c AS ReferrerName,
    Referrer.Name AS ReferrerContact,
    Referrer.Id AS ReferrerID,
    Referrer.NPI__c AS ReferrerNPI,
    Referrer.RecordTypeId AS ReferrerRecordType,
    Referrer.Email AS ReferrerEmail,
    Opp.Id AS OppID,
    Opp.StageName AS OppStage,
    Opp.Nurture_Last_Sent__c AS OppNurtureLastSent,
    LEAD.Id AS LeadId,
    LEAD.Status AS LeadStatus,
    LEAD.Nurture_Last_Sent__c AS LeadNurtureLastSent
FROM
    MR_Patient_Referral__c_Salesforce AS objReferral
    LEFT JOIN Contact_Salesforce Referrer ON objReferral.MR_Referring_Physician__c = Referrer.Id
    LEFT JOIN Opportunity_Salesforce Opp ON objReferral.Opportunity__c = Opp.Id
    LEFT JOIN Lead_Salesforce LEAD ON ObjReferral.Lead__c = LEAD.Id
WHERE
    (
        (
            (objReferral.Opportunity__c IS NOT NULL)
            AND (Opp.Nurture_Last_Sent__c IS NOT NULL)
        )
        OR (
            (objReferral.Lead__c IS NOT NULL)
            AND (LEAD.Nurture_Last_Sent__c IS NOT NULL)
        )
    )
