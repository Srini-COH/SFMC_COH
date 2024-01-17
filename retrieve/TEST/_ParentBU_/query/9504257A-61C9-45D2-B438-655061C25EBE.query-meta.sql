SELECT
    S.SubscriberKey,
    S.Status,
    S.EmailAddress,
    S.DateJoined,
    S.SubscriberType,
    L.IsConverted AS Converted,
    U.Name AS CreatedBy
FROM
    _Subscribers S
    LEFT JOIN Lead_Salesforce L ON SubscriberKey = L.Id
    LEFT JOIN User_Salesforce U ON L.CreatedById = U.Id
WHERE
    SubscriberKey LIKE '00Q%'
    AND SubscriberKey NOT LIKE '%@%'
