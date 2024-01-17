SELECT DISTINCT
    ObjOpportunity.Id AS OpportunityID,
    ObjOpportunity.ContactId__c AS ContactID,
    ObjOpportunity.Lead__C AS LeadId,
    ObjOpportunity.StageName AS Stage,
    ObjOpportunity.Last_Stage__c AS LastStage,
    ObjOpportunity.Purpose_of_call__c AS PurposeOfCall,
    ObjOpportunity.CreatedDate AS CreatedDate,
    Facility.Name AS SelectedFacility,
    ObjOpportunity.Primary_Segment__c AS Persona,
    ObjOpportunity.Segment_Tag_Terms__c AS SegmentTagTerms,
    ObjOpportunity.Insurance_Category__c AS InsuranceCategory,
    ObjOpportunity.Insurance_Submitted_Date__c AS InsuranceSubmittedDate,
    ObjOpportunity.Cancer_Type__c AS CancerType,
    CancerMapping.CancerGrouping AS CancerGroup,
    ObjOpportunity.Owner_Profile_Name__c AS OwnerProfileName,
    ObjOpportunity.Owner_Email__c AS OwnerEmail,
    ObjOpportunity.Nurture_Last_Sent__c AS NurtureLastSent,
    ObjOpportunity.Topics_Sent__c AS TopicsSent,
    Tx.CTCA1stTxDate AS CTCA1stTxDate
FROM
    [Opportunity_Salesforce] ObjOpportunity
    LEFT JOIN [Facilities__c_Salesforce] Facility ON (ObjOpportunity.Selected_Facility__c = Facility.Id)
    LEFT JOIN [Cancer_Type_Mapping_DE_Journey] CancerMapping ON (
        ObjOpportunity.Cancer_Type__c = CancerMapping.CancerType
    )
    INNER JOIN [JourneyTracking_DE] J ON ObjOpportunity.Lead__C = J.LeadId
    LEFT JOIN [ALL_TreatmentsFY22_DE] Tx ON ObjOpportunity.Lead__C = Tx.LeadID
WHERE
    J.JourneyName = 'LeadNurture'
    AND ObjOpportunity.Insurance_Submitted_Date__c >= '2021-07-01'
    AND ObjOpportunity.Insurance_Submitted_Date__c < '2021-10-01'
