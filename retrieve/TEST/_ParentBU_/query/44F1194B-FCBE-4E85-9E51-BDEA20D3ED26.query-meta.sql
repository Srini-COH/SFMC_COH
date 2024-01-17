SELECT
    Email,
    First_Name,
    Last_Name,
    Source,
    Date_Added,
    City,
    [State],
    Zip,
    Gender,
    Primary_Specialty AS DMD_Primary_Specialty,
    PSP AS DMD_PSP,
    UID_OUT AS DMD_UID_OUT,
    NPI AS DMD_NPI,
    Keycode AS DMD_Keycode
FROM
    [Physician_Primary]
WHERE
    Source = 'Physician_News'
    AND FORMAT(Date_Added, 'M/dd/yyyy') = FORMAT(GETDATE() - 1, 'M/dd/yyyy')
