/*
SQL Query of _Subscribers for Unsubscribes anytime yesterday.
*/
SELECT
    SubscriberID,
    SubscriberKey,
    EmailAddress,
    DateUnsubscribed,
    DateJoined,
    Status,
    'CTCA' AS SFMC_Account_Name,
    '100007281' AS Parent_BU_MID,
    GETDATE() AS DateAdded
FROM
    _Subscribers
WHERE
    DateUnsubscribed >= (DATEADD(dd, 0, DATEDIFF(dd, 0, GETDATE())) - 1)
    AND DateUnsubscribed < DATEADD(dd, 0, DATEDIFF(dd, 0, GETDATE()))
