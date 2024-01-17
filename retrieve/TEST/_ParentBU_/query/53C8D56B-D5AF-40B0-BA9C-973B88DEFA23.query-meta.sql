SELECT
    email,
    firstName AS First_Name,
    lastName AS Last_Name,
    practiceZip AS Zip,
    primarySpecialty AS Primary_Specialty,
    submitDate AS Date_Added,
    'Physician_News' AS Source
FROM
    [Forms_PhysicianNews]
WHERE
    FORMAT(submitDate, 'M/dd/yyyy') = FORMAT(GETDATE() - 1, 'M/dd/yyyy')
