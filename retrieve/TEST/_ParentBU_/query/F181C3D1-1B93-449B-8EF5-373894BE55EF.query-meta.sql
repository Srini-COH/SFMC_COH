SELECT
    firstName,
    lastName,
    email,
    submitDate,
    source,
    Date_Added,
    City,
    Zip,
    [Lead Source],
    Convio_Cons_ID,
    Convio_Donor_Status
FROM
    [combined_forms]
UNION
SELECT
    firstName,
    lastName,
    email,
    submitDate,
    source,
    Date_Added,
    City,
    Zip,
    [Lead Source],
    Convio_Cons_ID,
    Convio_Donor_Status
FROM
    [suporter_to_combine]
