SELECT
    CSN,
    [Unique FamGenix URL],
    EmailAddress,
    GETDATE() AS [Processed date time]
FROM
    Famgenix_Patient_info
WHERE
    [Processed date time] IS NULL
    AND CSN IN (
        SELECT
            CSN
        FROM
            Famgenix_Journey_DE
        WHERE
            [Processed date time] IS NULL
    )
