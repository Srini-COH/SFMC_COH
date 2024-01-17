SELECT
    oipr.Email,
    oipr.FirstName,
    oipr.LastName,
    subs.[Status] AS AllSubscribersStatus,
    prefpl.[Status] AS PLStatus,
    oipr.City,
    oipr.State,
    oipr.Gender,
    oipr.PrimarySpecialty,
    oipr.PSP,
    oipr.UID_Out,
    oipr.NPI,
    oipr.ZIP,
    subs.SubscriberKey
FROM
    ENT.Outreach_Import_PhysicianReferral oipr
    LEFT JOIN _Subscribers subs ON oipr.Email = subs.EmailAddress
    LEFT JOIN ENT._ListSubscribers prefpl ON oipr.Email = prefpl.EmailAddress
    AND prefpl.ListID = 18028
    LEFT JOIN ENT.CoH_Unsubscribes_Auto_Suppression autoSuppression ON oipr.Email = autoSuppression.[Email Address]
WHERE
    (
        subs.Status IS NULL
        OR subs.Status NOT IN ('Unsubscribed', 'Held')
    )
    AND (
        prefpl.Status IS NULL
        OR prefpl.Status NOT IN ('Unsubscribed', 'Held')
    )
    AND autoSuppression.[Email Address] IS NULL
