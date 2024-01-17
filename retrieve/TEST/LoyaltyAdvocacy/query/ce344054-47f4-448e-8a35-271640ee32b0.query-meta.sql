SELECT DISTINCT
    Contacts.Id AS ContactId,
    Contacts.Email AS EmailAddress,
    Contacts.CF_First_Name__c AS CF_First_Name__c,
    Contacts.CF_Last_Name__c AS CF_Last_Name__c,
    Contacts.Affiliated_Facility__c AS Affiliated_Facility__c,
    Contacts.How_were_you_affected_by_cancer__c AS ContactType,
    Contacts.ctca_iscancerfighter__c AS CancerFighterStatus,
    AllSubscribers.Status AS MCStatus,
    Contacts.CF_Member_Created_Date__c AS CF_MemberCreatedDate,
    Contacts.[Receive_valuable_info_from_CF__c] AS CFEmailOptIn,
    Contacts.ctca_medicalrecordnumber__c AS MRN,
    Contacts.prm_epid__c AS EPID,
    Contacts.ctca_stateprovince__c AS Address_State,
    Contacts.DMA__c AS DMA,
    Contacts.Cancer_Type__c AS CancerType,
    Contacts.Has_User_Account__c AS HasUserAccount,
    Contacts.CF_Point_Balance__c AS CFPointBalance,
    Contacts.CF_Engagement_Score__c AS CFEngagementScore
FROM
    ENT.Contact_Salesforce AS Contacts
    JOIN ENT.User_Salesforce U ON Contacts.Id = U.ContactId
    LEFT JOIN ENT._ListSubscribers AllSubscribers ON (
        Contacts.Id = AllSubscribers.SubscriberKey
        AND AllSubscribers.ListID = 24
    )
    LEFT JOIN ENT.Loyalty_Unengaged_Exclusion_Filtered_DE UnEngaged ON Contacts.Id = UnEngaged.SubscriberKey
WHERE
    (
        Contacts.ctca_iscancerfighter__c IN ('CF', 'CFCN')
    )
    AND (Contacts.Email IS NOT NULL)
    AND (
        Contacts.[Receive_valuable_info_from_CF__c] LIKE '1'
    )
    AND (
        Contacts.ctca_newstage__c IS NULL
        OR Contacts.ctca_newstage__c NOT LIKE 'Expired'
    )
    AND (Contacts.[HasOptedOutOfEmail] NOT LIKE '1')
    AND (Contacts.[Inactive_Member__c] NOT LIKE '1')
    AND (
        (AllSubscribers.Status IS NULL)
        OR (AllSubscribers.Status IN ('Active', 'Bounced'))
    )
    AND UnEngaged.SubscriberKey IS NULL
