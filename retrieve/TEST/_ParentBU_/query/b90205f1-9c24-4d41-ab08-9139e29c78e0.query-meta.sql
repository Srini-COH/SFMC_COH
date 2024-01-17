SELECT
    Contact.ID AS RecordID,
    Contact.Email AS EmailAddress,
    WeeklyEvents.[Firstname] AS Firstname,
    WeeklyEvents.[Lastname] AS Lastname,
    WeeklyEvents.ContactID AS ContactID
FROM
    [Contact_Salesforce] Contact
    INNER JOIN [Test Augwk4] WeeklyEvents ON Contact.Email = WeeklyEvents.[Email]
WHERE
    (
        (Contact.Email IS NOT NULL)
        AND Contact.ctca_iscancerfighter__c IN ('CF', 'CFCN')
        AND Contact.HasOptedOutofEmail = 'False'
        AND Contact.How_were_you_affected_by_cancer__c = 'Patient'
    )
