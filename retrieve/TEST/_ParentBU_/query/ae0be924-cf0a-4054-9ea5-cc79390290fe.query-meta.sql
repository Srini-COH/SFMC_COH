SELECT
    journeyActivity.VersionID,
    journeyActivity.ActivityID,
    journeyActivity.ActivityName,
    journeyActivity.ActivityExternalKey,
    journeyActivity.JourneyActivityObjectID,
    journeyActivity.ActivityType
FROM
    _JourneyActivity AS journeyActivity
