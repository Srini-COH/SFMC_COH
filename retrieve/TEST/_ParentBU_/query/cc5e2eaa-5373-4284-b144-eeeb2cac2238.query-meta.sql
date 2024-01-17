SELECT DISTINCT
    Tx.OpportunityId,
    Tx.Name,
    Tx.FirstName,
    Tx.LeadId,
    Tx.ContactId,
    Tx.Stage,
    Tx.LastStage,
    Tx.Email,
    Tx.ApptFacility,
    Tx.Persona,
    Tx.SegmentTagTerms,
    Tx.CancerType,
    Tx.CancerGroup,
    Tx.LeadScore,
    Tx.OppCreatedDate,
    Tx.PurposeOfCall,
    Tx.InsuranceCategory,
    Tx.NurtureLastSent,
    Tx.TopicsSent,
    Tx.NurturePreference,
    Tx.NurtureStatus,
    Tx.ContactStatus,
    Tx.HasOptedOutOfEmail,
    Tx.SubscriptionStatus,
    Tx.OwnerFirstName,
    Tx.OwnerLastName,
    Tx.OwnerEmail,
    Tx.OwnerPhone,
    Tx.OwnerAddress,
    Tx.OwnerProfileName,
    Tx.WelcomeKitEmailCount,
    Tx.WelcomeKitDMCount,
    Tx.CGWelcomeKitCount,
    Tx.ApptStatus,
    Tx.ApptDate,
    Tx.TotalWaitTimeToAppt,
    Tx.ApptResults,
    Tx.CTCA1stTxDate,
    Tx.ScheduledOn,
    Tx.IntakeType,
    Tx.ApptType,
    LEAD.LeadId AS Lead_NM_member,
    Ins.OpportunityId AS InsApproved_NM_Member,
    SNYK.OpportunityId AS SNYK_NM_Member,
    Cx.OpportunityId AS Canceled_NM_Member,
    Kept.OpportunityId AS KeptNoTx_NM_Member
FROM
    [OncTreatments_CCRC_FY23_DE] Tx
    LEFT JOIN [LeadNurture_Recipients_AllTime] LEAD ON Tx.LeadId = LEAD.LeadId
    LEFT JOIN [InsApprovedNurture_Recipients_AllTime] Ins ON Tx.OpportunityId = Ins.OpportunityId
    LEFT JOIN [SNYKNurture_Recipients_AllTime] SNYK ON Tx.OpportunityId = SNYK.OpportunityId
    LEFT JOIN [ApptCanceledNurture_Recipients_AllTime] Cx ON Tx.OpportunityId = Cx.OpportunityId
    LEFT JOIN [ApptKeptNoTxNurture_Recipients_AllTime] Kept ON Tx.OpportunityId = Kept.OpportunityId
WHERE
    (Tx.LeadId = LEAD.LeadId)
    OR (Tx.OpportunityId = Ins.OpportunityId)
    OR (Tx.OpportunityId = SNYK.OpportunityId)
    OR (Tx.OpportunityId = Cx.OpportunityId)
    OR (Tx.OpportunityId = Kept.OpportunityId)
