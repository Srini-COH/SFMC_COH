SELECT
    S.DateUndeliverable,
    S.DateUnsubscribed,
    S.EmailAddress,
    S.SubscriberKey,
    S.SubscriberType,
    S.Status
FROM
    _Subscribers S
WHERE
    S.Status = 'Unsubscribed'
