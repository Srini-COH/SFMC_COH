SELECT
    a.[Email] AS 'Cancel Center Email',
    b.[EmailAddress] AS 'EmailAddress'
FROM
    CancerCenter_DE a
    INNER JOIN Thrive_DE b ON a.Email = b.EmailAddress
    AND b.EmailAddress = 'kVasant@deloitte.com'
