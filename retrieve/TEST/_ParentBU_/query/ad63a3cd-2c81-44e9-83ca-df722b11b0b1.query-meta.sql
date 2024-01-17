SELECT DISTINCT
    OncAM.OpportunityID AS OpportunityID,
    OncAM.ContactID AS ContactID,
    OncAM.LeadID AS LeadID,
    OncAM.Stage AS Stage,
    OncAM.LastStage AS LastStage,
    OncAM.PurposeOfCall AS PurposeOfCall,
    OncAM.OppCreatedDate AS OppCreatedDate,
    OncAM.ApptFacility AS ApptFacility,
    OncAM.InsuranceCategory AS InsuranceCategory,
    OncAM.CancerType AS CancerType,
    OncAM.CancerGroup AS CancerGroup,
    OncAM.OwnerProfileName AS OwnerProfileName,
    OncAM.OwnerEmail AS OwnerEmail,
    OncAM.NurtureLastSent AS NurtureLastSent,
    OncAM.TopicsSent AS TopicsSent,
    OncAM.ScheduledOn AS ScheduledOn,
    Tx.CTCA1stTxDate AS CTCA1stTxDate
FROM
    [OncApptMade_CCRC_FY23_DE] OncAM
    INNER JOIN [JourneyTracking_DE] J ON OncAM.OpportunityID = J.OpportunityId
    LEFT JOIN [OncTreatments_CCRC_FY23_DE] Tx ON OncAM.OpportunityId = Tx.OpportunityId
WHERE
    J.JourneyName = 'Insurance Approved'
    AND OncAM.ScheduledOn >= '2022-10-01'
    AND OncAM.ScheduledOn < '2023-10-01'
