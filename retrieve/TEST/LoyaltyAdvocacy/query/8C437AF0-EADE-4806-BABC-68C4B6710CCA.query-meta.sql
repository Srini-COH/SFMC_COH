SELECT DISTINCT
    Contacts.Id AS ContactId,
    Contacts.Email AS EmailAddress,
    Contacts.CF_First_Name__c AS CF_First_Name__c,
    Contacts.CF_Last_Name__c AS CF_Last_Name__c,
    Contacts.Affiliated_Facility__c AS CF_Facility,
    Contacts.How_were_you_affected_by_cancer__c AS ContactType,
    Contacts.ctca_iscancerfighter__c AS CancerFighterStatus,
    AllSubscribers.Status AS MCStatus,
    Contacts.CF_Member_Created_Date__c AS CF_MemberCreatedDate,
    Contacts.[Receive_valuable_info_from_CF__c] AS CFEmailPermission,
    /* BEGIN Identify if MRN is assigned */
    CASE
        WHEN Contacts.ctca_medicalrecordnumber__c IS NULL THEN 'No'
        WHEN Contacts.ctca_medicalrecordnumber__c IS NOT NULL THEN 'Yes'
    END AS Has_MRN,
    /* END Identify if MRN is assigned */
    Contacts.CF_Point_Balance__c AS HopePoints,
    Account.Celebrant_Eligible__c AS CelebrantEligible,
    U.Username AS Username
FROM
    ENT.Contact_Salesforce AS Contacts
    LEFT JOIN ENT.User_Salesforce U ON U.ContactId = Contacts.Id
    INNER JOIN ENT.Account_Salesforce Account ON Contacts.AccountId = Account.Id
    LEFT JOIN ENT._ListSubscribers AllSubscribers ON (
        Contacts.Id = AllSubscribers.SubscriberKey
        AND AllSubscribers.ListID = 24
    )
    LEFT JOIN ENT.Loyalty_Unengaged_Exclusion_Filtered_DE UnEngaged ON Contacts.Id = UnEngaged.SubscriberKey
WHERE
    (
        Contacts.ctca_iscancerfighter__c IN ('CF', 'CFCN')
    )
    AND (
        Contacts.CF_Member_Created_Date__c <= DATEADD(DAY, -4, GETDATE())
    )
    AND U.Username IS NOT NULL
    AND UnEngaged.SubscriberKey IS NULL
    /*AND Contacts.CF_First_Name__c IS NOT NULL
    
    AND Contacts.How_were_you_affected_by_cancer__c = 'Patient'
    AND Contacts.Affiliated_Facility__c IN ('CTCA, Atlanta','CTCA, Chicago','CTCA, Phoenix')*/
    AND (Contacts.Email IS NOT NULL)
    AND (
        Contacts.[Receive_valuable_info_from_CF__c] LIKE '1'
    )
    AND (Contacts.[HasOptedOutOfEmail] NOT LIKE '1')
    AND (
        (Contacts.ctca_newstage__c IS NULL)
        OR (Contacts.ctca_newstage__c NOT LIKE 'Expired')
    )
    AND (Account.Expired__c NOT LIKE '1')
    AND (Contacts.HealthCloudGA__DeceasedDate__c IS NULL)
    AND (Contacts.[Inactive_Member__c] NOT LIKE '1')
    AND AllSubscribers.Status = 'Active'
