SELECT DISTINCT
    s.SubscriberKey,
    s.Emailaddress AS 'Email'
FROM
    [_Subscribers] s
    LEFT OUTER JOIN [_open] o ON s.SubscriberID = o.SubscriberID
WHERE
    (o.SubscriberID IS NULL)
