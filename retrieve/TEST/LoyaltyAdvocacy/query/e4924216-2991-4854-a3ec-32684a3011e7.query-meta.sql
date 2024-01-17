SELECT DISTINCT
    Contacts.Id AS ContactId,
    Contacts.Email AS EmailAddress,
    Contacts.CF_First_Name__c AS CF_First_Name__c,
    Contacts.CF_Last_Name__c AS CF_Last_Name__c,
    Contacts.Affiliated_Facility__c AS CF_Facility,
    Contacts.How_were_you_affected_by_cancer__c AS ContactType,
    Contacts.ctca_iscancerfighter__c AS CancerFighterStatus,
    AllSubscribers.Status AS MCStatus,
    Contacts.[Receive_valuable_info_from_CF__c] AS CFEmailPermission,
    Contacts.CF_Member_Created_Date__c AS CF_MemberCreatedDate
FROM
    ENT.Contact_Salesforce AS Contacts
    LEFT JOIN ENT._ListSubscribers AllSubscribers ON (
        Contacts.Id = AllSubscribers.SubscriberKey
        AND AllSubscribers.ListID = 24
    )
WHERE
    DATEPART(YEAR, Contacts.CF_Member_Created_Date__c) = (DATEPART(YEAR, DATEADD(YEAR, -1, GETDATE())))
    AND DATEPART(d, Contacts.CF_Member_Created_Date__c) = DATEPART(d, GETDATE())
    AND DATEPART(m, Contacts.CF_Member_Created_Date__c) = DATEPART(m, GETDATE())
    /*Query to use if this becomes anniversary for everyone:
    (DATEPART(d, Contacts.CF_Member_Created_Date__c) = DATEPART(d, GETDATE())
    AND DATEPART(m, Contacts.CF_Member_Created_Date__c) = DATEPART(m, GETDATE())
    )
    AND (Contacts.CF_Member_Created_Date__c <= DATEADD(day, -100, GETDATE()))
    */
    /*if CTCA patient restrictions are needed:
    AND Contacts.How_were_you_affected_by_cancer__c = 'Patient'
    AND ((Contacts.Affiliated_Facility__c IS NOT NULL) and (Contacts.Affiliated_Facility__c NOT LIKE 'Other'))
    */
    AND (
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
