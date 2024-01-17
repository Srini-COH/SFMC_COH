SELECT
    u.Id AS SubscriberKey
FROM
    Excluded_No_Channel d
    INNER JOIN User_Salesforce u ON d.SubscriberKey = u.Id
