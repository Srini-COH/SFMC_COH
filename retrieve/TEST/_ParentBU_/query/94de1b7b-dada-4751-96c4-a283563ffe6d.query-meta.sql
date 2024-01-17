SELECT DISTINCT
    OncIS.OpportunityId AS OpportunityID,
    OncIS.ContactId AS ContactID,
    OncIS.LeadID AS LeadId,
    OncIS.Stage AS Stage,
    OncIS.LastStage AS LastStage,
    OncIS.PurposeOfCall AS PurposeOfCall,
    OncIS.OppCreatedDate AS CreatedDate,
    OncIS.SelectedFacility AS SelectedFacility,
    OncIS.InsuranceCategory AS InsuranceCategory,
    OncIS.CancerType AS CancerType,
    OncIS.CancerGroup AS CancerGroup,
    OncIS.OwnerProfileName AS OwnerProfileName,
    OncIS.OwnerEmail AS OwnerEmail,
    OncIS.NurtureLastSent AS NurtureLastSent,
    OncIS.TopicsSent AS TopicsSent,
    Tx.CTCA1stTxDate AS CTCA1stTxDate
FROM
    [OncInsSubmitted_CCRC_FY23_DE] OncIS
    INNER JOIN [JourneyTracking_DE] J ON OncIS.LeadID = J.LeadId
    LEFT JOIN [OncTreatments_CCRC_FY23_DE] Tx ON OncIS.LeadID = Tx.LeadID
WHERE
    J.JourneyName = 'LeadNurture'
    AND OncIS.OppCreatedDate >= '2022-10-01'
    AND OncIS.OppCreatedDate < '2023-10-01'
