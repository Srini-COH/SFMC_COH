SELECT
    List1.SubscriberKey,
    List1.EmailAddress,
    List1.ListName,
    List1.ListType,
    List1.CreatedDate AS DateAdded,
    List1.Status,
    List1.DateUnsubscribed
FROM
    [_ListSubscribers] List1
    INNER JOIN [_ListSubscribers] List2 ON List1.EmailAddress = List2.EmailAddress
    AND List1.ListName = List2.ListName
    AND List1.SubscriberKey != List2.SubscriberKey
