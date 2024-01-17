SELECT
    d.SubscriberKey
FROM
    Excluded_No_Channel_Batch3 d
WHERE
    NOT EXISTS (
        SELECT
            SubscriberKey
        FROM
            [_ListSubscribers] l
        WHERE
            ListID = 24
            AND d.SubscriberKey = l.SubscriberKey
    )
