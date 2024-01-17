SELECT DISTINCT
    ObjOpportunity.Id AS OpportunityId,
    ObjOpportunity.ContactId__c AS ContactId,
    ObjOpportunity.StageName AS Stage,
    ObjOpportunity.Last_Stage__c AS LastStage,
    FV.ctca_apptstatus__c AS ApptStatus,
    (FV.ctca_1sttxdate__c) AS '1stTxDate',
    Facility.Name AS TxFacility,
    ObjOpportunity.Name AS Name,
    Contacts.FirstName AS FirstName,
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
    Invitees.Name AS NameFromTargetList
FROM
    ENT.Opportunity_Salesforce AS ObjOpportunity
    INNER JOIN ENT.Contact_Salesforce AS Contacts ON ObjOpportunity.ContactId__c = Contacts.Id
    INNER JOIN ENT.Facility_Visits__c_Salesforce AS FV ON ObjOpportunity.Id = FV.Opportunity__c
    INNER JOIN ENT.Facilities__c_Salesforce AS Facility ON (FV.ctca_txfacility_id__c = Facility.Id)
    INNER JOIN JoinCF_Targeted_List AS Invitees ON (ObjOpportunity.Email__c = Invitees.Email)
    LEFT JOIN ENT._ListSubscribers AllSubscribers ON ObjOpportunity.ContactId__c = AllSubscribers.SubscriberKey
WHERE
    (FV.ctca_apptstatus__c LIKE 'Scheduled')
    AND (
        FV.ctca_1sttxdate__c <= DATEADD(DAY, -7, GETDATE())
    )
    /*	AND (ObjOpportunity.StageName LIKE 'Treated')*/
    AND Contacts.ctca_iscancerfighter__c IS NULL
    /*AND (ObjOpportunity.Purpose_of_call__c IS NULL OR ObjOpportunity.Purpose_of_call__c NOT IN ('Non-Oncology'))*/
    AND (ObjOpportunity.Email__c IS NOT NULL)
    AND (ObjOpportunity.Email__c NOT LIKE '%@dmctca.com%')
    AND (ObjOpportunity.Contact_Status__c IS NULL)
    AND (Contacts.ctca_newstage__c NOT LIKE 'Expired')
    AND (Contacts.HasOptedOutOfEmail NOT LIKE '1')
    AND (ObjOpportunity.Name NOT LIKE '%unk%')
    AND (ObjOpportunity.Name NOT LIKE '%delete%')
