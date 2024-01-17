SELECT
    s.SubscriberKey,
    s.sent,
    s.Delivered,
    s.[Unique Open],
    c.[Unique Click]
FROM
    [Sent_Del_Open] s
    LEFT JOIN [Click_Report] c ON s.SubscriberKey = c.SubscriberKey
