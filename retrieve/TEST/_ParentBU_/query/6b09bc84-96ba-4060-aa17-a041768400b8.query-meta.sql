SELECT
    s.SubscriberKey
FROM
    Lead_Salesforce l
    INNER JOIN _Subscribers s ON l.Id = s.SubscriberKey
WHERE
    l.HasOptedOutofEmail = 1
    AND s.Status = 'Active'
UNION
SELECT
    s.SubscriberKey
FROM
    Contact_Salesforce c
    INNER JOIN _Subscribers s ON c.Id = s.SubscriberKey
WHERE
    c.HasOptedOutofEmail = 1
    AND s.Status = 'Active'
