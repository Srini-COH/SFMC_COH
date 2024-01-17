SELECT
    Contact.[ID] AS RecordID,
    Contact.[Email] AS EmailAddress,
    Contact.[CF_First_Name__c] AS CF_First_Name__c,
    Contact.[CF_Last_Name__c] AS Lastname,
    Contact.[Affiliated_Facility__c] AS CF_Facility,
    Contact.[Cancer_Type__c] AS CancerType,
    Contact.[ctca_iscancerfighter__c] AS CancerFighterStatus,
    Contact.[ctca_stateprovince__c] AS State,
    Contact.[DMA__c] AS DMA,
    Contact.[How_were_you_affected_by_cancer__c] AS ContactType
FROM
    [CF_All_Patient_DE] Contact
    INNER JOIN [JourneyBook_Philadelphia] WeeklyEvents ON Contact.Email = WeeklyEvents.Email
