SELECT
    j.JobID,
    j.EmailID,
    j.EmailName,
    s.SubscriberKey,
    s.EventDate
FROM
    _Job j
    JOIN _Sent s ON j.JobID = s.JobId
WHERE
    j.EmailID IN (
        '13056',
        '13233',
        '14230',
        '14136',
        '14581',
        '23800',
        '24487',
        '40259',
        '40121',
        '38566',
        '53557'
    )
