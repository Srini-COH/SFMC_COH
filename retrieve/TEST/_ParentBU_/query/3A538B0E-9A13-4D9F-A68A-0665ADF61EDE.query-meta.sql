SELECT DISTINCT
    Leads.Id AS SubscriberKey,
    'active' AS Status,
    Leads.Email AS EmailAddress
FROM
    [Lead_Salesforce] Leads
    INNER JOIN [_ListSubscribers] AllSubscribers ON Leads.Id = AllSubscribers.SubscriberKey
WHERE
    AllSubscribers.Status = 'active'
    AND Leads.Marketing_Cloud_Status__c != 'active'
    AND Leads.Marketing_Cloud_Status__c <> AllSubscribers.Status
