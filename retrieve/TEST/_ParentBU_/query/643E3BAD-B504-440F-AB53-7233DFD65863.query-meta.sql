SELECT
    firstName AS First_Name,
    lastName AS Last_Name,
    email,
    submitDate AS Date_Added,
    'Breakthroughs' AS Source
FROM
    [Forms_Breakthroughs]
WHERE
    FORMAT(submitDate, 'M/dd/yyyy') = FORMAT(GETDATE() - 1, 'M/dd/yyyy')
