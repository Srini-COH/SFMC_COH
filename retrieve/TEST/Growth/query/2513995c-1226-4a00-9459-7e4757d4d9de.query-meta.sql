SELECT
    CCNL.Email,
    CCNL.Status,
    CCNL.CancerOfInterest,
    CCNL.cancerrelationship,
    [Topics of Interest],
    [Cancers of Interest],
    [Relationship to Cancer],
    [Email Permission Date],
    [Permission Source],
    CCNL.Membersince,
    CCNL.SystemUnsubscribeReason,
    AllSubscribers.Status AS SFMC_Status
FROM
    ENT.CancerCenter_DE CCNL
    LEFT JOIN ENT.Growth_Unengaged_Exclusion_Filtered_DE UnEngaged ON CCNL.Email = UnEngaged.SubscriberKey
    LEFT JOIN ENT._ListSubscribers AllSubscribers ON (
        CCNL.Email = AllSubscribers.SubscriberKey
        AND AllSubscribers.ListID = 24
    )
WHERE
    CCNL.Email IS NOT NULL
    AND CCNL.Status = 'Active'
    AND UnEngaged.SubscriberKey IS NULL
    AND (
        (AllSubscribers.Status IS NULL)
        OR (AllSubscribers.Status IN ('Active', 'Bounced'))
    )
