SELECT
    journey.VersionID,
    journey.JourneyID,
    journey.JourneyName,
    journey.VersionNumber,
    journey.CreatedDate,
    journey.LastPublishedDate,
    journey.ModifiedDate,
    journey.JourneyStatus
FROM
    _Journey AS journey
