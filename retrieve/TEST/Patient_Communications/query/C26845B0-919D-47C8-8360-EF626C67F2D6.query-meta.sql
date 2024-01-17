SELECT
    LName,
    FName,
    DoB,
    Gender,
    [Scheduling or Ordering Provider],
    [Unique FamGenix URL],
    EmailAddress,
    CSN,
    Status,
    [Processed date time]
FROM
    [Famgenix_Patient_info]
WHERE
    [Processed date time] BETWEEN DATEADD(d, -1, GETDATE()) AND GETDATE()
