SELECT
    Event.Start_Time__c AS EventDate,
    Reg.Contact__c AS ContactID,
    Contacts.FirstName AS FirstName,
    Event.Location__c AS CL_Location,
    Contacts.Email AS Email
FROM
    ENT.Event_Registration__c_Salesforce Reg
    INNER JOIN ENT.Event__c_Salesforce Event ON Event.Id = Reg.Event__c
    INNER JOIN ENT.Contact_Salesforce Contacts ON Reg.Contact__c = Contacts.Id
WHERE
    Event.Start_Time__c < DATEADD(DAY, + 31, GETDATE())
    AND Event.Name IN (
        /*'2023 City of Hope Chicago Celebrate Life','2023 City of Hope Phoenix Celebrate Life',*/ '2023 City of Hope Atlanta Celebrate Life'
    )
    AND Reg.Status__c = 'Registered'
    AND (Contacts.Email IS NOT NULL)
    AND Contacts.Email NOT LIKE '%nopatientemail%'
    AND Contacts.Email NOT LIKE '%noemail%'
    AND Contacts.Email NOT LIKE '%none@%'
    AND (
        (Contacts.ctca_newstage__c IS NULL)
        OR (Contacts.ctca_newstage__c NOT LIKE 'Expired')
    )
    AND (Contacts.HasOptedOutOfEmail NOT LIKE '1')
