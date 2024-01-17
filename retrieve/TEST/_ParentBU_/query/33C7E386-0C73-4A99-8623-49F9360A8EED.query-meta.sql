SELECT
    c.Id,
    l.List_Name,
    c.Name,
    s.Status
FROM
    Contact_Salesforce c
    INNER JOIN Contacts_UploadedforDeletion_NotSynchedInCNet l ON l.Id = c.Id
    LEFT JOIN _Subscribers s ON c.Id = s.SubscriberKey
