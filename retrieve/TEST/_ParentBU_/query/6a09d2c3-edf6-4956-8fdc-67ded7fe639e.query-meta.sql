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
    (
        SELECT
            COUNT(Name)
        FROM
            Fulfillment__c_Salesforce
        WHERE
            (
                ObjOpportunity.Id = Opportunity__c
                AND Lead__c IS NOT NULL
                AND Fulfillment_Type__c = 'Welcome Kit'
                AND Method__c = 'Email'
            )
    ) AS LeadPtWelcomeEmailCount,
    (
        SELECT
            COUNT(Name)
        FROM
            Fulfillment__c_Salesforce
        WHERE
            (
                ObjOpportunity.Id = Opportunity__c
                AND Lead__c IS NOT NULL
                AND Fulfillment_Type__c = 'Welcome Kit'
                AND Method__c = 'Direct Mail'
            )
    ) AS LeadPtWelcomeDMCount,
    (
        SELECT
            COUNT(Name)
        FROM
            Fulfillment__c_Salesforce
        WHERE
            (
                ObjOpportunity.Id = Opportunity__c
                AND Lead__c IS NOT NULL
                AND Fulfillment_Type__c = 'Welcome Kit (Caregiver)'
                AND Method__c = 'Email'
            )
    ) AS LeadCGWelcomeEmailCount
FROM
    [Opportunity_Salesforce] ObjOpportunity
    LEFT JOIN [Facilities__c_Salesforce] Facility ON (ObjOpportunity.Selected_Facility__c = Facility.Id)
    LEFT JOIN [Cancer_Type_Mapping_DE_Journey] CancerMapping ON (
        ObjOpportunity.Cancer_Type__c = CancerMapping.CancerType
    )
WHERE
    ObjOpportunity.RecordTypeId = '0121C000001RL6JQAW' /*(this is the ID for the Opportunity Record Type "Prospect Patient"*/
    AND ObjOpportunity.Insurance_Submitted_Date__c >= '2019-07-01'
    AND ObjOpportunity.Insurance_Submitted_Date__c <= '2020-06-30'
