SELECT
    objContact.Id AS ContactID,
    objContact.Email AS EmailAddress,
    objContact.CF_First_Name__c AS CF_First_Name__c,
    ObjContact.CF_Last_Name__c AS Lastname,
    objContact.Affiliated_Facility__C AS CF_Facility,
    objContact.ctca_iscancerfighter__c AS CancerFighterStatus,
    objContact.How_were_you_affected_by_cancer__c AS ContactType,
    objContact.Birthdate AS Birthdate,
    objContact.Birthdate_CF__c AS Birthdate_CF__c,
    objContact.[Receive_valuable_info_from_CF__c] AS 'Receive_valuable_info_from_CF__c'
FROM
    ENT.Contact_Salesforce AS objContact
WHERE
    objContact.Email IS NOT NULL
    AND objContact.ctca_iscancerfighter__c IN ('CF', 'CFCN')
    AND (
        DATEPART(d, objContact.Birthdate) = DATEPART(d, GETDATE())
        AND DATEPART(m, objContact.Birthdate) = DATEPART(m, GETDATE())
    )
    AND objContact.How_were_you_affected_by_cancer__c = 'Patient'
    AND objContact.FirstName NOT LIKE '%unk%'
    AND objContact.HasOptedOutOfEmail NOT LIKE '1'
    AND objContact.[Receive_valuable_info_from_CF__c] LIKE '1'
    AND objContact.ctca_newstage__c NOT LIKE 'Expired'
    AND (objContact.[Inactive_Member__c] NOT LIKE '1')
