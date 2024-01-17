SELECT
    SubscriberKey,
    Status,
    EmailAddress,
    DateJoined,
    SubscriberType
FROM
    _Subscribers
WHERE
    SubscriberKey NOT LIKE '%@%'
    AND SubscriberKey LIKE '003%'
