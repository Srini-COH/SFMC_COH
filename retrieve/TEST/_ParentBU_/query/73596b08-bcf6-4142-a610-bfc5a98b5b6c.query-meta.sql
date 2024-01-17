SELECT DISTINCT
    OncAK.OpportunityID AS OpportunityID,
    OncAK.ContactID AS ContactID,
    OncAK.LeadID AS LeadID,
    OncAK.Stage AS Stage,
    OncAK.LastStage AS LastStage,
    OncAK.PurposeOfCall AS PurposeOfCall,
    OncAK.OppCreatedDate AS OppCreatedDate,
    OncAK.InsuranceCategory AS InsuranceCategory,
    OncAK.CancerType AS CancerType,
    OncAK.CancerGroup AS CancerGroup,
    OncAK.OwnerProfileName AS OwnerProfileName,
    OncAK.OwnerEmail AS OwnerEmail,
    OncAK.NurtureLastSent AS NurtureLastSent,
    OncAK.TopicsSent AS TopicsSent,
    OncAK.ScheduledOn AS ScheduledOn,
    OncAK.ApptDate AS ApptDate,
    OncAK.ApptFacility AS ApptFacility,
    OncAK.ApptStatus AS ApptStatus,
    Tx.CTCA1stTxDate AS CTCA1stTxDate
FROM
    [OncApptKept_CCRC_FY23_DE] OncAK
    INNER JOIN [JourneyTracking_DE] J ON OncAK.OpportunityID = J.OpportunityId
    LEFT JOIN [OncTreatments_CCRC_FY23_DE] Tx ON OncAK.OpportunityId = Tx.OpportunityId
WHERE
    J.JourneyName = 'Appointment Canceled'
    AND OncAK.ApptDate >= '2022-10-01'
    AND OncAK.ApptDate < '2023-10-01'
