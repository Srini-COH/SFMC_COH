SELECT
    TOP 1
WITH
    TIES casted.Email,
    casted.Optin_Date AS 'Email Permission Date',
    'Casted' AS 'Permission Source',
    'Active' AS 'Status'
FROM
    FocusOnCancer_Casted_DE casted
    LEFT JOIN FocusOnCancer_Preference_DE pref ON casted.Email = pref.Email
WHERE
    pref.Email IS NULL
    AND casted.Optin_Date >= DATEADD(DAY, -1, GETDATE())
ORDER BY
    ROW_NUMBER() OVER (
        PARTITION BY
            casted.Email
        ORDER BY
            casted.Optin_Date DESC
    )
