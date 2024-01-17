SELECT
    email,
    firstName,
    lastName,
    zip,
    submitDate AS Date_Added,
    source
FROM
    [Web MD]
WHERE
    FORMAT(submitDate, 'M/dd/yyyy') = FORMAT(GETDATE() - 1, 'M/dd/yyyy')
