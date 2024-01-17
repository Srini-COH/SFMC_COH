SELECT
    Contact.[ID] AS ContactID,
    Contact.[Email] AS EmailAddress,
    Contact.[CF_First_Name__c] AS CF_First_Name__c,
    Contact.[CF_Last_Name__c] AS CF_Last_Name__c,
    Contact.[Affiliated_Facility__c] AS CF_Facility,
    Contact.[How_were_you_affected_by_cancer__c] AS ContactType,
    Contact.[ctca_iscancerfighter__c] AS CancerFighterStatus,
    AllSubscribers.Status AS MCStatus,
    Contact.[Receive_valuable_info_from_CF__c] AS CFReceiveValuableInfo,
    Contact.[ctca_stateprovince__c] AS State,
    Contact.[DMA__c] AS DMA
FROM
    [CF_CTCA_Caregiver_DE] Contact
    INNER JOIN [CF_Caregiver_Upload_for_Targeting_by_Email] CGList ON Contact.[Email] = CGList.Email
    LEFT JOIN ENT._ListSubscribers AllSubscribers ON Contact.[ID] = AllSubscribers.SubscriberKey
