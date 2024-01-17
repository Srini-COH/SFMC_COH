SELECT
    c.Id AS ContactID,
    l.npi AS ListNPI,
    c.NPI__c AS CNetNPI,
    l.firstName AS ListFirstName,
    c.FirstName AS CNetFirstName,
    l.lastName AS ListLastName,
    c.LastName AS CNetLastName,
    l.EmailAddress AS ListEmail,
    c.Email AS CNetEmail,
    l.zip AS ListZip,
    /*c.MailingPostalCode as CNetZip,*/
    l.state AS ListState,
    c.ctca_stateprovince__c AS CNetState,
    l.primarySpecialty AS ListPrimarySpecialty,
    /*c.PD_Primary_Specialty__c as CnetPrimarySpecialty,*/
    l.uidOut,
    c.HasOptedOutOfEmail AS EmailOptOut
FROM
    ENT.SAMPLE_DMD l
    LEFT JOIN ENT.Contact_Salesforce c ON l.npi = c.NPI__c
