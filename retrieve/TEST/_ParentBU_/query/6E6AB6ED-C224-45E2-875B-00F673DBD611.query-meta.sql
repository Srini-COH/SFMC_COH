SELECT
    SubscriberKey,
    Status,
    EmailAddress,
    GETDATE() AS DateLogged
FROM
    MarketingCloudStatus_to_Update_in_CRM
