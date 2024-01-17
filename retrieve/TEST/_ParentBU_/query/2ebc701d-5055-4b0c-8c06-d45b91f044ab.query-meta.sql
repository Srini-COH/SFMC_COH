SELECT
    d.SubscriberKey
FROM
    No_Channel_Contacts d
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
