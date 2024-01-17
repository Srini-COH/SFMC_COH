SELECT DISTINCT
    ObjOpportunity.Id AS OpportunityId,
    ObjOpportunity.Name AS Name,
    Contacts.FirstName AS FirstName,
    ObjOpportunity.ContactId__c AS ContactId,
    ObjOpportunity.StageName AS Stage,
    ObjOpportunity.Last_Stage__c AS LastStage,
    ObjOpportunity.Email__c AS Email,
    /*TxFacility.Name as TxFacility,*/
    ObjOpportunity.Cancer_Type__c AS CancerType,
    CancerMapping.CancerGrouping AS CancerGroup,
    ObjOpportunity.Lead_Score__c AS LeadScore,
    ObjOpportunity.CreatedDate AS OppCreatedDate,
    ObjOpportunity.ECOG__c AS ECOG,
    ObjOpportunity.Purpose_of_call__c AS PurposeOfCall,
    ObjOpportunity.Insurance_Category__c AS InsuranceCategory,
    ObjOpportunity.Nurture_Last_Sent__c AS NurtureLastSent,
    ObjOpportunity.Topics_Sent__c AS TopicsSent,
    ObjOpportunity.Nurture_Preference__c AS NurturePreference,
    ObjOpportunity.Nurture_Status__c AS NurtureStatus,
    ObjOpportunity.Contact_Status__c AS ContactStatus,
    Contacts.HasOptedOutOfEmail AS HasOptedOutOfEmail,
    AllSubscribers.Status AS SubscriptionStatus,
    ObjOpportunity.Owner_First_Name__c AS OwnerFirstName,
    ObjOpportunity.Owner_Last_Name__c AS OwnerLastName,
    ObjOpportunity.Owner_Email__c AS OwnerEmail,
    ObjOpportunity.Owner_Phone__c AS OwnerPhone,
    ObjOpportunity.Owner_Profile_Name__c AS OwnerProfileName,
    FV.ctca_apptstatus__c AS ApptStatus,
    FV.ctca_apptdate__c AS ApptDate,
    FV.ctca_appointmentresults__c AS ApptResults,
    (FV.ctca_1sttxdate__c) AS '1stTxDate',
    FV.ctca_scheduledon__c AS ScheduledOn,
    Facility.Name AS SelectedFacility
FROM
    [Opportunity_Salesforce] ObjOpportunity
    LEFT JOIN [_ListSubscribers] AllSubscribers ON ObjOpportunity.ContactId__c = AllSubscribers.SubscriberKey
    INNER JOIN [Facilities__c_Salesforce] Facility ON (ObjOpportunity.Selected_Facility__c = Facility.Id)
    INNER JOIN [Contact_Salesforce] Contacts ON ObjOpportunity.ContactId__c = Contacts.Id
    INNER JOIN [Facility_Visits__c_Salesforce] FV ON ObjOpportunity.Id = FV.Opportunity__c
    /*LEFT JOIN [Facilities__c_Salesforce] TxFacility ON (FV.ctca_txfacility_id__c = Facility.Id )*/
    LEFT JOIN [Cancer_Type_Mapping_DE_Journey] CancerMapping ON (
        ObjOpportunity.Cancer_Type__c = CancerMapping.CancerType
    )
WHERE
    (FV.ctca_apptstatus__c IN ('Scheduled', 'Other'))
    AND (
        FV.ctca_1sttxdate__c >= DATEADD(YEAR, -5, GETDATE())
    )
    AND (
        FV.ctca_1sttxdate__c <= DATEADD(DAY, -1, GETDATE())
    )
    AND (ObjOpportunity.Email__c IS NOT NULL)
    AND (ObjOpportunity.Email__c NOT LIKE '%@dmctca.com%')
    AND (ObjOpportunity.Contact_Status__c IS NULL)
    AND (Contacts.ctca_newstage__c NOT LIKE 'Expired')
    /*	AND (ObjOpportunity.StageName NOT IN ('Insurance Denied','Closed Lost','Treated'))
    
    
    AND ObjOpportunity.Owner_Profile_Name__c IN ('NPES','Scheduler', 'Patient Advocate', 'Facilitator','Super Advocate Pilot','Advocate Manager')
    
    AND (ObjOpportunity.Purpose_of_call__c IS NULL OR ObjOpportunity.Purpose_of_call__c NOT IN ('Non-Oncology'))
    
    AND Facility.Name LIKE '%RMC%'
    AND (ObjOpportunity.Cancer_Type__c IS NOT NULL)
    AND (ObjOpportunity.Lead_Score__c >(10) )
    
    
    AND (Contacts.HasOptedOutOfEmail NOT LIKE '1')
    AND ((ObjOpportunity.Nurture_Preference__c IS NULL) OR (ObjOpportunity.Nurture_Preference__c NOT IN ('Declined')))
    AND ((ObjOpportunity.Nurture_Status__c IS NULL) OR (ObjOpportunity.Nurture_Status__c NOT IN ('Declined')))  
    AND (ObjOpportunity.Name NOT LIKE '%unk%')
    AND (ObjOpportunity.Name NOT LIKE '%delete%')
    */
