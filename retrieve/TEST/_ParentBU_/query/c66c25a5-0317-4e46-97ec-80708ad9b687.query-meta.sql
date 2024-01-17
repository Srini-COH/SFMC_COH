SELECT DISTINCT
    OncTx.OpportunityID AS OpportunityID,
    OncTx.ContactID AS ContactID,
    OncTx.LeadID AS LeadID,
    OncTx.Stage AS Stage,
    OncTx.LastStage AS LastStage,
    OncTx.PurposeOfCall AS PurposeOfCall,
    OncTx.OppCreatedDate AS OppCreatedDate,
    OncTx.InsuranceCategory AS InsuranceCategory,
    OncTx.CancerType AS CancerType,
    OncTx.CancerGroup AS CancerGroup,
    OncTx.OwnerProfileName AS OwnerProfileName,
    OncTx.OwnerEmail AS OwnerEmail,
    OncTx.NurtureLastSent AS NurtureLastSent,
    OncTx.TopicsSent AS TopicsSent,
    OncTx.ScheduledOn AS ScheduledOn,
    OncTx.ApptDate AS ApptDate,
    OncTx.ApptFacility AS ApptFacility,
    OncTx.ApptStatus AS ApptStatus,
    OncTx.CTCA1stTxDate AS CTCA1stTxDate
FROM
    [OncTreatments_CCRC_FY23_DE] OncTx
    INNER JOIN [JourneyTracking_DE] J ON OncTx.OpportunityID = J.OpportunityId
WHERE
    (
        (J.JourneyName = 'Appointment Kept')
        AND (J.DateSent < OncTx.CTCA1stTxDate)
    )
    AND OncTx.CTCA1stTxDate >= '2022-10-01'
    AND OncTx.CTCA1stTxDate < '2023-10-01'
