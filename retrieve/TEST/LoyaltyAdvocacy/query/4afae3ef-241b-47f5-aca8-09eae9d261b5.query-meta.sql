SELECT DISTINCT
    ObjOpportunity.Id AS OpportunityId,
    ObjOpportunity.ContactId__c AS ContactId,
    ObjOpportunity.StageName AS Stage,
    ObjOpportunity.Last_Stage__c AS LastStage,
    FV.ctca_apptstatus__c AS ApptStatus,
    (FV.ctca_1sttxdate__c) AS '1stTxDate',
    Facility.Name AS TxFacility,
    Contacts.Affiliated_Facility__c AS Affiliated_Facility,
    ObjOpportunity.Name AS Name,
    Contacts.FirstName AS CF_First_Name__c,
    Contacts.LastName AS LastName,
    ObjOpportunity.Email__c AS Email,
    ObjOpportunity.Primary_Segment__c AS Persona,
    ObjOpportunity.Segment_Tag_Terms__c AS SegmentTagTerms,
    ObjOpportunity.Cancer_Type__c AS CancerType,
    ObjOpportunity.Purpose_of_call__c AS PurposeOfCall,
    Contacts.ctca_iscancerfighter__c AS CFStatus,
    Contacts.[Receive_valuable_info_from_CF__c] AS CFReceiveInfoPermission,
    ObjOpportunity.Contact_Status__c AS ContactStatus,
    Contacts.HasOptedOutOfEmail AS HasOptedOutOfEmail,
    AllSubscribers.Status AS SubscriptionStatus,
    Contacts.How_did_you_hear_about_CF__c AS HowDidYouHearAboutCF,
    Contacts.CF_Member_Created_Date__c AS CF_Member_Created_Date,
    ObjOpportunity.CFCN_Offered__c AS CFCN_Status,
    (
        SELECT
            COUNT(Name)
        FROM
            ENT.Resource_Request__c_Salesforce
        WHERE
            (
                ObjOpportunity.Id = Opportunity__c
                AND Resource_Type__c = 'CFCN'
            )
    ) AS CFCN_Count
FROM
    ENT.Opportunity_Salesforce AS ObjOpportunity
    INNER JOIN ENT.Contact_Salesforce AS Contacts ON ObjOpportunity.ContactId__c = Contacts.Id
    LEFT JOIN ENT.Account_Salesforce Account ON Contacts.AccountId = Account.Id
    INNER JOIN ENT.Facility_Visits__c_Salesforce AS FV ON ObjOpportunity.Id = FV.Opportunity__c
    INNER JOIN ENT.Facilities__c_Salesforce AS Facility ON (FV.ctca_txfacility_id__c = Facility.Id)
    LEFT JOIN ENT._ListSubscribers AllSubscribers ON ObjOpportunity.ContactId__c = AllSubscribers.SubscriberKey
WHERE
    (FV.ctca_apptstatus__c LIKE 'Scheduled')
    AND (
        Contacts.CF_Member_Created_Date__c >= '2020-04-01'
    )
    AND (
        Contacts.CF_Member_Created_Date__c <= DATEADD(DAY, -7, GETDATE())
    )
    AND (
        (ObjOpportunity.CFCN_Offered__c IS NULL)
        OR (
            ObjOpportunity.CFCN_Offered__c IN ('Not Offered', 'Offered/Undecided')
        )
    )
    AND Contacts.ctca_iscancerfighter__c IN ('CF', 'CFCN')
    AND (ObjOpportunity.Email__c IS NOT NULL)
    AND (ObjOpportunity.Email__c NOT LIKE '%@dmctca.com%')
    AND (ObjOpportunity.Contact_Status__c IS NULL)
    AND (Contacts.ctca_newstage__c NOT LIKE 'Expired')
    AND (Account.Expired__c NOT LIKE '1')
    AND (Contacts.HealthCloudGA__DeceasedDate__c IS NULL)
    AND (Contacts.HasOptedOutOfEmail NOT LIKE '1')
    AND (
        Contacts.[Receive_valuable_info_from_CF__c] LIKE '1'
    )
    AND (Contacts.[Inactive_Member__c] NOT LIKE '1')
    AND (ObjOpportunity.Name NOT LIKE '%unknown%')
    AND (ObjOpportunity.Name NOT LIKE '%delete%')
