/*Employers_Only_Target_Audience_DE
Used for Employer Communications where audience is Employers Only*/
SELECT
    c.Id AS [ContactId],
    c.Email AS [Email],
    c.FirstName AS [FirstName],
    c.LastName AS [LastName],
    c.Title AS [Title],
    c.Status__c AS [Contact_Status],
    c.AccountId AS [AccountId],
    a.Name AS [Account_Name],
    a.Type AS [Account_Type],
    a.Region__c AS [Account_Region],
    c.OwnerId AS [OwnerID],
    c.Owner_FirstName__c AS [Owner_FirstName],
    c.Owner_Profile_Name__c AS [Owner_ProfileName],
    c.Owner_Signature__c AS [Owner_Signature],
    u.Email AS [Owner_Email],
    c.HasOptedOutOfEmail AS [HasOptedOutOfEmail],
    c.Employer_Communication_Status__c AS [Employer_Communication_Status],
    c.Employer_Communication_Preferences__c AS [Employer_Communication_Preferences],
    c.CreatedById AS [CreatedByID],
    c.CreatedDate AS [CreatedDate],
    c.LastModifiedById AS [LastModifiedById],
    c.RecordTypeId AS [RecordTypeId],
    u.Name AS [Owner_FullName],
    CONCAT(u.Name, ', CTCA') AS SenderName
FROM
    ENT.Contact_Salesforce c
    LEFT JOIN ENT.Account_Salesforce a ON c.AccountId = a.Id
    LEFT JOIN ENT.User_Salesforce u ON u.Id = c.OwnerID
    LEFT JOIN ENT.Loyalty_Unengaged_Exclusion_Filtered_DE UnEngaged ON c.Id = UnEngaged.SubscriberKey
WHERE
    c.Email IS NOT NULL
    AND c.HasOptedOutOfEmail = 'False'
    AND c.Id IS NOT NULL
    AND c.RecordTypeId = '0121C000001cwsPQAQ'
    AND (
        (a.Type IS NULL)
        OR (
            a.Type NOT IN ('Aggregator', 'Broker', 'Carrier/Payer', 'TPA')
        )
    )
    AND c.Employer_Communication_Status__c = 'Enrolled'
    AND (
        c.Employer_Communication_Preferences__c IS NULL
        OR c.Employer_Communication_Preferences__c != 'Declined'
    )
    AND UnEngaged.SubscriberKey IS NULL
