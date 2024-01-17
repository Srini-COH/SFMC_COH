SELECT
    de.EmailAddress
FROM
    [validity_seed_list_E08367] de
    JOIN [_listsubscribers] l ON de.EmailAddress = l.SubscriberKey
WHERE
    l.ListName = 'All Subscribers'
    AND l.[Status] != 'active'
