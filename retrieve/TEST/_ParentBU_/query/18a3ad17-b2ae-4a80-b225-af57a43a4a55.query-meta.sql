SELECT
    sub.SubscriberID,
    sub.DateUndeliverable,
    sub.DateJoined,
    sub.DateUnsubscribed,
    sub.Domain,
    sub.EmailAddress,
    sub.BounceCount,
    sub.SubscriberKey,
    sub.SubscriberType,
    sub.Status,
    sub.Locale
FROM
    _Subscribers AS sub
