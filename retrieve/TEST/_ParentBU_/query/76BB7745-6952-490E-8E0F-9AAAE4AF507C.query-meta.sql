SELECT
    Email,
    First_Name,
    Last_Name,
    Source,
    Zip,
    City,
    Date_Added
FROM
    [Consumer_Primary]
WHERE
    Source IN ('Breakthroughs', 'Web_MD')
    AND FORMAT(Date_Added, 'M/dd/yyyy') = FORMAT(GETDATE() - 1, 'M/dd/yyyy')
