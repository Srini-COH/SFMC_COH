/*UE_RelationshipMktg_All_Sends_Grouped*/
SELECT DISTINCT
    TOP 100000 s.SubscriberKey,
    s.EmailAddress,
    CASE
        WHEN COUNT(s.OpenDate) < 1
        AND COUNT(s.BouncedDate) < 1
        AND COUNT(s.ClickDate) < 1 THEN 'Unengaged'
        ELSE 'Engaged'
    END AS Engagement_Status,
    MIN(s.SentDate) AS EarliestEmailSentDate,
    MAX(s.SentDate) AS LatestEmailSentDate,
    s2.number_of_sends AS NumSentWithin6Mo,
    s3.number_of_sends AS NumSentBefore5Mo,
    COUNT(s.SentDate) AS EmailSentCount,
    COUNT(s.OpenDate) AS EmailOpenCount,
    COUNT(s.ClickDate) AS EmailClickCount,
    COUNT(s.BouncedDate) AS EmailBouncedCount,
    s.AllSubscribersCreatedDate
FROM
    UE_RelationshipMktg_All_DV_Sends s
    JOIN (
        SELECT
            x2.subscriberkey,
            COUNT(x2.sentdate) AS number_of_sends
        FROM
            UE_RelationshipMktg_All_DV_Sends x2
        WHERE
            x2.sentdate >= DATEADD(mm, -6, GETDATE())
        GROUP BY
            x2.subscriberkey
        HAVING
            COUNT(x2.sentdate) >= 6
    ) s2 ON s2.subscriberkey = s.subscriberkey
    JOIN (
        SELECT
            x3.subscriberkey,
            COUNT(x3.sentdate) AS number_of_sends
        FROM
            UE_RelationshipMktg_All_DV_Sends x3
        WHERE
            x3.sentdate <= DATEADD(mm, -5, GETDATE())
        GROUP BY
            x3.subscriberkey
        HAVING
            COUNT(x3.sentdate) >= 1
    ) s3 ON s3.subscriberkey = s.subscriberkey
GROUP BY
    s.EmailAddress,
    s.SubscriberKey,
    s2.number_of_sends,
    s3.number_of_sends,
    s.AllSubscribersCreatedDate
