SELECT
    jo.JourneyName,
    jo.VersionNumber,
    ja.ActivityName,
    ja.ActivityType,
    j.EmailName,
    s.EventDate,
    s.SubscriberKey
FROM
    _Job j
    INNER JOIN _Sent s ON j.JobID = s.JobID
    INNER JOIN _JourneyActivity ja ON s.TriggererSendDefinitionObjectID = ja.JourneyActivityObjectID
    INNER JOIN _Journey jo ON ja.VersionID = jo.VersionID
WHERE
    s.EventDate >= DATEADD(d, -7, GETDATE())
    AND jo.JourneyName = 'Nurture_AppointmentScheduled_Journey'
    AND j.EmailName = 'SNYK - Traveling to CTCA'
