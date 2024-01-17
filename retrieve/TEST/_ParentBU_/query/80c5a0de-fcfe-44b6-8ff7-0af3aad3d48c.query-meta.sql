SELECT
    TOP 1
WITH
    TIES casted.Email,
    casted.Optin_Date AS 'Email Permission Date',
    'Casted' AS 'Permission Source',
    'Active' AS 'Status'
FROM
    FocusOnCancer_Casted_DE casted
    INNER JOIN FocusOnCancer_Preference_DE pref ON casted.Email = pref.Email
WHERE
    casted.Optin_Date >= DATEADD(DAY, -1, GETDATE())
    AND casted.Optin_Date > pref.[Email Permission Date]
ORDER BY
    ROW_NUMBER() OVER (
        PARTITION BY
            casted.Email
        ORDER BY
            casted.Optin_Date DESC
    )
