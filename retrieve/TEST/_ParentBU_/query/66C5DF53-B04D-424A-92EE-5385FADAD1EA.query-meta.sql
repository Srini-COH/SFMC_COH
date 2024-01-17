SELECT
    Subscriberkey,
    '0' AS Delivered
FROM
    _bounce
WHERE
    JobID = '228244'
