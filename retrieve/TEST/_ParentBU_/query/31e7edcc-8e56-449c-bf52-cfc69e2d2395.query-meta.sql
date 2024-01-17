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
    Appt.ScheduledOn AS ScheduledOn,
    Tx.CTCA1stTxDate AS CTCA1stTxDate
FROM
    [Opportunity_Salesforce] ObjOpportunity
    INNER JOIN [JourneyTracking_DE] J ON ObjOpportunity.Id = J.OpportunityId
    INNER JOIN [ALL_AppointmentMadeFY22_DE] Appt ON ObjOpportunity.Id = Appt.OpportunityId
    LEFT JOIN [Facilities__c_Salesforce] Facility ON (ObjOpportunity.Selected_Facility__c = Facility.Id)
    LEFT JOIN [Cancer_Type_Mapping_DE_Journey] CancerMapping ON (
        ObjOpportunity.Cancer_Type__c = CancerMapping.CancerType
    )
    LEFT JOIN [ALL_TreatmentsFY22_DE] Tx ON ObjOpportunity.Id = Tx.OpportunityId
WHERE
    J.JourneyName = 'Insurance Approved'
    AND Appt.ScheduledOn >= '2021-07-01'
    AND Appt.ScheduledOn < '2021-10-01'
