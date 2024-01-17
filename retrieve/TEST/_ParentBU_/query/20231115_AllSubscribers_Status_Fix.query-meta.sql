SELECT
    pc.GUID,
    pc.Email,
    pc.CancerCenter,
    pc.CancerCompass,
    pc.CancerFighters,
    pc.HereandNow,
    pc.Educational,
    pc.RiskManagement,
    pc.UnsubscribeFromAll,
    pc.CreatedDate,
    pc.FocusOnCancer,
    pc.OJOH,
    pc.EmployerRelations,
    pc.CelebrateLife,
    pc.PhysicianRelations,
    pc.CityStories,
    pc.PatientAlerts,
    pc.PatientNewsletter,
    pc.PatientOfferings,
    pc.CME,
    pc.PhysicianReputation,
    pc.PhysicianReferral,
    s.SubscriberKey,
    s.Status
FROM
    Preference_Center_Log pc
    LEFT JOIN _Subscribers s ON pc.Email = s.EmailAddress
WHERE
    (
        (
            pc.CME = 'False'
            AND pc.PhysicianReputation = 'False'
            AND pc.PhysicianReferral = 'False'
        )
        OR (
            pc.CancerCenter = 'False'
            AND pc.CancerFighters = 'False'
            AND pc.CelebrateLife = 'False'
            AND pc.CityStories = 'False'
            AND pc.OJOH = 'False'
            AND pc.PatientAlerts = 'False'
            AND pc.PatientNewsletter = 'False'
            AND pc.PatientOfferings = 'False'
            AND pc.Educational = 'False'
            AND pc.RiskManagement = 'False'
        )
    )
    AND (
        s.Status != 'unsubscribed'
        OR s.Status IS NULL
    )
    AND pc.CreatedDate >= '2023-08-15'
