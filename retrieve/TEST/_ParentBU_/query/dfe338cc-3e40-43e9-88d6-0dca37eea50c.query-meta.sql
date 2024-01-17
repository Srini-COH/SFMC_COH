SELECT
    u.id AS [Id],
    u.Email AS [Email],
    u.IsActive AS [IsActive]
FROM
    User_Salesforce u
    INNER JOIN Users_UploadedforDeletion_InactiveInCNet list ON u.id = list.UserID
