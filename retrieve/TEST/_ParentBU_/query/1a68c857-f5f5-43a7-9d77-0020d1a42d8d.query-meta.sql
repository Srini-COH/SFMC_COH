SELECT DISTINCT
    ObjOpportunity.Id AS OpportunityId,
    ObjOpportunity.Name AS Name,
    ObjOpportunity.Lead_First_Name__c AS FirstName,
    ObjOpportunity.Lead__C AS LeadId,
    ObjOpportunity.ContactId__c AS ContactId,
    ObjOpportunity.StageName AS Stage,
    ObjOpportunity.Last_Stage__c AS LastStage,
    ObjOpportunity.Email__c AS Email,
    Facility.Name AS ApptFacility,
    ObjOpportunity.Primary_Segment__c AS Persona,
    ObjOpportunity.Segment_Tag_Terms__c AS SegmentTagTerms,
    ObjOpportunity.Cancer_Type__c AS CancerType,
    CancerMapping.CancerGrouping AS CancerGroup,
    ObjOpportunity.Lead_Score__c AS LeadScore,
    ObjOpportunity.CreatedDate AS OppCreatedDate,
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
    ObjOpportunity.Owner_Address__c AS OwnerAddress,
    ObjOpportunity.Owner_Profile_Name__c AS OwnerProfileName,
    ObjOpportunity.CFCN_Offered__c AS CFCNOfferStatus,
    ObjOpportunity.CFCN_Offered_Date__c AS CFCNOfferDate,
    (
        SELECT
            COUNT(Name)
        FROM
            Resource_Request__c_Salesforce
        WHERE
            (
                ObjOpportunity.Id = Opportunity__c
                AND Resource_Type__c = 'Physician Prospect Call Program'
            )
    ) AS PhoneaDoc,
    (
        SELECT
            COUNT(Name)
        FROM
            Resource_Request__c_Salesforce
        WHERE
            (
                ObjOpportunity.Id = Opportunity__c
                AND Resource_Type__c = 'CFCN'
            )
    ) AS CFCNConnections,
    (
        SELECT
            COUNT(Name)
        FROM
            Fulfillment__c_Salesforce
        WHERE
            (
                ObjOpportunity.Id = Opportunity__c
                AND Fulfillment_Type__c = 'Welcome Kit'
                AND Method__c = 'Email'
            )
    ) AS WelcomeKitEmailCount,
    (
        SELECT
            COUNT(Name)
        FROM
            Fulfillment__c_Salesforce
        WHERE
            (
                ObjOpportunity.Id = Opportunity__c
                AND Fulfillment_Type__c = 'Welcome Kit'
                AND Method__c = 'Direct Mail'
            )
    ) AS WelcomeKitDMCount,
    (
        SELECT
            COUNT(Name)
        FROM
            Fulfillment__c_Salesforce
        WHERE
            (
                ObjOpportunity.Id = Opportunity__c
                AND Fulfillment_Type__c = 'Welcome Kit (Caregiver)'
            )
    ) AS CGWelcomeKitCount,
    FV.ctca_apptstatus__c AS ApptStatus,
    FV.ctca_apptdate__c AS ApptDate,
    FV.Days_Between_Appt_and_Appt_Scheduled__c AS TotalWaitTimeToAppt,
    FV.ctca_appointmentresults__c AS ApptResults,
    (FV.ctca_1sttxdate__c) AS 'ctca_1stTxDate',
    FV.ctca_scheduledon__c AS ScheduledOn,
    ObjOpportunity.Intake_Type__c AS IntakeType,
    FV.Appointment_Type__c AS ApptType
FROM
    [Opportunity_Salesforce] ObjOpportunity
    INNER JOIN [Contact_Salesforce] Contacts ON ObjOpportunity.ContactId__c = Contacts.Id
    INNER JOIN [Facility_Visits__c_Salesforce] FV ON ObjOpportunity.Id = FV.Opportunity__c
    LEFT JOIN [Cancer_Type_Mapping_DE_Journey] CancerMapping ON (
        ObjOpportunity.Cancer_Type__c = CancerMapping.CancerType
    )
    LEFT JOIN [Facilities__c_Salesforce] Facility ON (FV.ctca_facilityid__c = Facility.Id)
    LEFT JOIN [_ListSubscribers] AllSubscribers ON (
        ObjOpportunity.ContactId__c = AllSubscribers.SubscriberKey
        AND AllSubscribers.ListID = 24
    )
WHERE
    (
        ObjOpportunity.Intake_Type__c IS NULL
        OR ObjOpportunity.Intake_Type__c NOT IN ('Non-Oncology')
    )
    AND (FV.ctca_apptstatus__c LIKE 'Scheduled')
    AND Facility.Name LIKE '%RMC%'
    /*this 2nd/later date below should be set to the first day after the latest CLOSED month*/
    AND FV.ctca_apptdate__c >= '2021-10-01'
    AND FV.ctca_apptdate__c < '2022-10-01'
