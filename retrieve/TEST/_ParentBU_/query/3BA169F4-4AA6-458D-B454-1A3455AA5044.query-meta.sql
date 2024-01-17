SELECT
    firstName AS First_Name,
    lastName AS Last_Name,
    email,
    state,
    zip,
    submitDate AS Date_Added,
    'ProfessionalEducation' AS Source
FROM
    [Forms_ProfessionalEducation]
WHERE
    FORMAT(submitDate, 'M/dd/yyyy') = FORMAT(GETDATE() - 1, 'M/dd/yyyy')
