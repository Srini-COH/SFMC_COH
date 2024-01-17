SELECT
    s.SubscriberKey,
    s.sent,
    s.Delivered,
    o.[Unique Open]
FROM
    [Sent_Delivered_report] s
    LEFT JOIN [Open_report] o ON s.SubscriberKey = o.SubscriberKey
