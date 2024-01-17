SELECT
    c.ContactKey,
    s.SubscriberKey
FROM
    AllContacts_DE c
    LEFT JOIN _subscribers s ON c.ContactKey = s.SubscriberKey
WHERE
    c.ContactKey LIKE '%@%'
    AND s.SubscriberKey IS NULL
