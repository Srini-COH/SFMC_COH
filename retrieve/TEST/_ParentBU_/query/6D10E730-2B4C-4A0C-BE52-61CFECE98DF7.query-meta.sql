SELECT
    firstName AS First_Name,
    lastName AS Last_Name,
    email,
    State,
    Zip,
    submitDate AS Date_Added,
    'Careers' AS Source
FROM
    [Forms_Careers]
WHERE
    FORMAT(submitDate, 'M/dd/yyyy') = FORMAT(GETDATE() - 1, 'M/dd/yyyy')
