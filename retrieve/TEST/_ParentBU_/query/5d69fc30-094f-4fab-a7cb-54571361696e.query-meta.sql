SELECT
    SubscriberKey
FROM
    _Subscribers s
WHERE
    NOT EXISTS (
        SELECT
            Id
        FROM
            Contact_Salesforce
        WHERE
            Id = s.SubscriberKey
    )
    AND SubscriberKey LIKE '003%'
UNION
SELECT
    SubscriberKey
FROM
    _Subscribers s
WHERE
    NOT EXISTS (
        SELECT
            Id
        FROM
            Lead_Salesforce
        WHERE
            Id = s.SubscriberKey
    )
    AND SubscriberKey LIKE '00Q%'
