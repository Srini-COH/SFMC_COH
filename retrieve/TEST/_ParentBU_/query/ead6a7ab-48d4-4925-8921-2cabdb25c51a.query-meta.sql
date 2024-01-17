SELECT
    s.eventdate AS sent_date,
    sub.emailaddress AS emailaddress,
    s.subscriberkey AS subscriberkey,
    sub.Status AS subscriber_status,
    j.EmailName AS email_name,
    j.jobid AS jobid,
    j.DeliveredTime AS delivered_time
FROM
    _Job j
    JOIN _Sent s ON s.jobid = j.jobid
    JOIN _Subscribers sub ON sub.subscriberkey = s.subscriberkey
WHERE
    j.jobid IN (
        '605212',
        '605208',
        '605213',
        '605206',
        '605209',
        '592913',
        '605195'
    )
