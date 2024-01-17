SELECT
    listSub.AddedBy,
    listSub.AddMethod,
    listSub.CreatedDate,
    listSub.DateUnsubscribed,
    listSub.EmailAddress,
    listSub.ListID,
    listSub.ListName,
    listSub.ListType,
    listSub.Status,
    listSub.SubscriberID,
    listSub.SubscriberKey,
    listSub.SubscriberType
FROM
    _ListSubscribers AS listSub
