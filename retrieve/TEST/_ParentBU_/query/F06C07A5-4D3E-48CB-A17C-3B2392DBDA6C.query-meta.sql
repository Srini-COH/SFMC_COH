SELECT
    firstName AS First_Name,
    lastName AS Last_Name,
    email,
    state,
    zip,
    submitDate AS Date_Added,
    'FundraisingSupport' AS Source
FROM
    [Forms_FundraisingSupport]
WHERE
    FORMAT(submitDate, 'M/dd/yyyy') = FORMAT(GETDATE() - 1, 'M/dd/yyyy')
