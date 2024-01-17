SELECT
    l.Id AS SubscriberKey
FROM
    Excluded_No_Channel d
    INNER JOIN Lead_Salesforce l ON d.SubscriberKey = l.Id
