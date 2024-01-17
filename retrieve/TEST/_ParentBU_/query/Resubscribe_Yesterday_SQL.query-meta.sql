/*
SQL Query of _Subscribers and Subscription_Status_Sync_Log DE for Resubscribes anytime yesterday.
*/
SELECT
    _Subscribers.SubscriberID,
    _Subscribers.SubscriberKey,
    _Subscribers.EmailAddress,
    _Subscribers.DateUnsubscribed,
    _Subscribers.DateJoined,
    _Subscribers.Status,
    'CTCA' AS SFMC_Account_Name,
    '100007281' AS Parent_BU_MID,
    GETDATE() AS DateAdded
FROM
    _Subscribers
    INNER JOIN Subscription_Status_Sync_Log ON _Subscribers.SubscriberKey = Subscription_Status_Sync_Log.SubscriberKey
WHERE
    _Subscribers.Status = 'active'
    AND Subscription_Status_Sync_Log.Subscription_Status = 'Unsubscribe'
