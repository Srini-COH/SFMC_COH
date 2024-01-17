SELECT
    c.ContactKey,
    sc.Id
FROM
    AllContacts_DE c
    LEFT JOIN Contact_Salesforce sc ON c.ContactKey = sc.Id
WHERE
    c.ContactKey LIKE '003%'
    AND sc.Id IS NULL
