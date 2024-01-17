SELECT
    SubscriberKey
FROM
    JourneyHistoryCheck j
WHERE
    SubscriberKey NOT IN (
        SELECT
            SubscriberKey
        FROM
            IntegrativeEmailSendCheck
    )
