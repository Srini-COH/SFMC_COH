SELECT
    List1.SubscriberKey,
    List1.EmailAddress,
    List1.ListName
FROM
    [_ListSubscribers] List1
GROUP BY
    List1.SubscriberKey,
    List1.EmailAddress,
    List1.ListName
HAVING
    COUNT(List1.EmailAddress) > 1
