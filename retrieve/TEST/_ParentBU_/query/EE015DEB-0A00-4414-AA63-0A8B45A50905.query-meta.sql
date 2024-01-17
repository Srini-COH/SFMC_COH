SELECT
    Email,
    First_Name,
    Last_Name,
    Zip,
    Date_Added,
    'OC_Global' AS Source
FROM
    [Forms_OC]
WHERE
    FORMAT(Date_Added, 'M/dd/yyyy') = FORMAT(GETDATE() - 1, 'M/dd/yyyy')
