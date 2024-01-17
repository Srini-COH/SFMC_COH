SELECT DISTINCT
    EmailAddr AS Email,
    Status,
    FirstName,
    LastName,
    Screenname,
    ccid,
    MemberSince,
    WantsWUNewsLetter,
    UpdatedDate,
    CF.CF_Status AS CancerFighterStatus
FROM
    ENT.ActiveCancerCompassSubscribers CC
    LEFT JOIN ENT.ExclusionListForCFInvite CF ON CC.EmailAddr = CF.Email
