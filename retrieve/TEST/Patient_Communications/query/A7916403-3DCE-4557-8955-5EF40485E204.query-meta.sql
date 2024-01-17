SELECT
    f.CSN AS CSN,
    f.LName AS LName,
    f.FName AS FName,
    f.DoB AS DoB,
    f.Gender AS Gender,
    f.[Scheduling or Ordering Provider] AS [Scheduling or Ordering Provider],
    f.[Unique FamGenix URL] AS [Unique FamGenix URL],
    f.EmailAddress AS EmailAddress,
    f.Status AS Status,
    f.[Processed date time] AS [Processed date time],
    C.Id AS [ContactId]
FROM
    [Famgenix_Patient_info] f
    LEFT JOIN ent.Account_Salesforce a ON a.EPIC_medicalrecordnumber__c = f.MRN
    LEFT JOIN ent.Contact_Salesforce c ON c.AccountId = a.Id
WHERE
    [Processed date time] IS NULL
    AND C.Id IS NOT NULL
