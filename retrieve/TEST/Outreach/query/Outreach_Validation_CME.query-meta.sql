SELECT
    oic.Email,
    oic.FirstName,
    oic.LastName,
    subs.[Status] AS AllSubscribersStatus,
    cmepl.[Status] AS PLStatus,
    subs.SubscriberKey,
    oic.NPI
FROM
    ENT.Outreach_Import_CME oic
    LEFT JOIN _Subscribers subs ON oic.Email = subs.EmailAddress
    LEFT JOIN ENT._ListSubscribers cmepl ON oic.Email = cmepl.EmailAddress
    AND cmepl.ListID = 18026
    LEFT JOIN ENT.CoH_Unsubscribes_Auto_Suppression autoSuppression ON oic.Email = autoSuppression.[Email Address]
WHERE
    (
        subs.Status IS NULL
        OR subs.Status NOT IN ('Unsubscribed', 'Held')
    )
    AND (
        cmepl.Status IS NULL
        OR cmepl.Status NOT IN ('Unsubscribed', 'Held')
    )
    AND autoSuppression.[Email Address] IS NULL
