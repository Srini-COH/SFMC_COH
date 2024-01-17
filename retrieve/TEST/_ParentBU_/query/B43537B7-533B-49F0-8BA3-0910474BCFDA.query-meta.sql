SELECT
    r.Sent,
    r.Delivered,
    r.[Unique Open],
    r.[Unique Click],
    u.[primarySpecialty] AS [Primary Specialty],
    u.state,
    u.npi
FROM
    [Report_All] r
    LEFT JOIN [June 2023 National Oncs] u ON r.SubscriberKey = u.EMAIL
