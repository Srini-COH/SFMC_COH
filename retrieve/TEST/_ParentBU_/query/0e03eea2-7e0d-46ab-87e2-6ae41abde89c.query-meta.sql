SELECT
    ContactId AS SubscriberKey,
    RecordInsertDate
FROM
    SNYK_Journey_Qualifiers_DE q
    INNER JOIN SNYK_Emails_Sent_Log l ON l.SubscriberKey = q.ContactId
WHERE
    EmailName LIKE '%Integrative%'
