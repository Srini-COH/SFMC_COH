SELECT
    j.ContactId AS SubscriberKey
FROM
    SNYK_Journey_Qualifiers_DE j
    INNER JOIN SNYK_Journey_Reference_DE d1 ON j.ContactId = d1.ContactId
    INNER JOIN SNYK_Emails_Sent_Log d2 ON d1.ContactId = d2.SubscriberKey
WHERE
    d2.EmailName LIKE '%Integrative%'
    /* AND d2.EventDate < j.EventDate */
