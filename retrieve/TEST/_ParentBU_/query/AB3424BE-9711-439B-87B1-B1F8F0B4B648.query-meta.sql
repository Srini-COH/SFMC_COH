SELECT
    s.SubscriberKey,
    s.sent,
    b.Delivered
FROM
    [sent_report] s
    LEFT JOIN [Bounced_report] b ON s.SubscriberKey = b.SubscriberKey
