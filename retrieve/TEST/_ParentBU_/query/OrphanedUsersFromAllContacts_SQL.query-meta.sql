SELECT
    c.ContactKey,
    u._ContactKey AS Id
FROM
    AllContacts_DE c
    LEFT JOIN User_Salesforce u ON c.ContactKey = u._ContactKey
WHERE
    (
        (c.ContactKey LIKE '005%')
        OR (c.ContactKey LIKE '%-%-%-%-%')
    )
    AND u._ContactKey IS NULL
