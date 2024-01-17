SELECT
    c.ContactKey,
    s.SubscriberKey
FROM
    OrphanedContactsFromAllContacts c
    LEFT JOIN _subscribers s ON c.ContactKey = s.SubscriberKey
WHERE
    s.SubscriberKey IS NULL
