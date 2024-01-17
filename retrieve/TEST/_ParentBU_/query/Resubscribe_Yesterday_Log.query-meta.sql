/*
SQL Query of Resubscribe_Yesterday_DE for all fields on all records. Writes these records, a Subscription Status of 'Unsubscribe', and a Timestamp to Subscription_Status_Sync_Log DE.
*/
SELECT
    SubscriberID,
    SubscriberKey,
    EmailAddress,
    DateUnsubscribed,
    DateJoined,
    Status,
    SFMC_Account_Name,
    Parent_BU_MID,
    'Resubscribe' AS Subscription_Status,
    GETDATE() AS Log_Timestamp,
    DateAdded
FROM
    Resubscribe_Yesterday_DE
