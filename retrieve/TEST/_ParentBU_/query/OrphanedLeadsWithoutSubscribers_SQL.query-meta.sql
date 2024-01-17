SELECT
    c.ContactKey,
    s.SubscriberKey
FROM
    OrphanedLeadsFromAllContacts c
    LEFT JOIN _subscribers s ON c.ContactKey = s.SubscriberKey
WHERE
    s.SubscriberKey IS NULL
