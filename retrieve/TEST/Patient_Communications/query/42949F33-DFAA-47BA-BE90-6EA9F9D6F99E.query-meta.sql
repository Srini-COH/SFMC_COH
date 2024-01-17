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
    CASE
        WHEN C.Id IS NOT NULL THEN C.Id
        ELSE CONCAT('FMGX_', f.EmailAddress, '_FMGX')
    END AS [ContactId]
    /*C.Id as [ContactId]*/
FROM
    [Test_Famgenix_Patient_info] f
    LEFT JOIN ent.Account_Salesforce a ON a.EPIC_medicalrecordnumber__c = f.MRN
    LEFT JOIN ent.Contact_Salesforce c ON c.AccountId = a.Id
WHERE
    [Processed date time] IS NULL
    /*and C.Id is not null*/
