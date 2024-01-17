SELECT
    [Id] AS [Contact ID]
FROM
    Contact_DoNotSync
WHERE
    [Id] NOT IN (
        SELECT
            [Contact ID]
        FROM
            MedicalStaff_DoNotSync_1
    )
