SELECT DISTINCT
    ObjOpportunity.Id AS OpportunityId,
    ObjOpportunity.Name AS Name,
    Contacts.FirstName AS FirstName,
    ObjOpportunity.ContactId__c AS ContactId,
    ObjOpportunity.StageName AS Stage,
    ObjOpportunity.Last_Stage__c AS LastStage,
    ObjOpportunity.Email__c AS Email,
    Facility.Name AS ApptFacility,
    ObjOpportunity.Primary_Segment__c AS Persona,
    ObjOpportunity.Cancer_Type__c AS CancerType,
    CancerMapping.CancerGrouping AS CancerGroup,
    ObjOpportunity.Cancer_Status__c AS CancerStatus,
    ObjOpportunity.Cancer_Stage__c AS CancerStage,
    ObjOpportunity.Previous_Treatment_Type__c AS PreviousTreatmentType,
    ObjOpportunity.Lead_Score__c AS LeadScore,
    ObjOpportunity.CreatedDate AS OppCreatedDate,
    ObjOpportunity.ECOG__c AS ECOG,
    ObjOpportunity.Purpose_of_call__c AS PurposeOfCall,
    ObjOpportunity.Insurance_Category__c AS InsuranceCategory,
    ObjOpportunity.Nurture_Last_Sent__c AS NurtureLastSent,
    ObjOpportunity.Topics_Sent__c AS TopicsSent,
    /*no longer used:
    ObjOpportunity.Nurture_Message_Counter__c as MessageCounter,
    ObjOpportunity.Nurture_Tile1_Counter__c as Tile1Counter,
    ObjOpportunity.Nurture_Tile2_Counter__c as Tile2Counter,
    ObjOpportunity.Nurture_Tile3_Counter__c as Tile3Counter,
    ObjOpportunity.Segment_Tag_Terms__c as SegmentTagTerms,
    ObjOpportunity.Owner_Address__c as OwnerAddress,
    ObjOpportunity.Direct_Mailable__c as DirectMailable,
    */
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
    FV.ctca_apptstatus__c AS ApptStatus,
    FV.ctca_apptdate__c AS ApptDate,
    FV.Cancellation_Risk_Score__c AS CancellationRiskScore,
    FV.Days_Between_Appt_and_Appt_Scheduled__c AS TotalWaitTimeToAppt,
    FV.NN_Appointment_Date__c AS NurseNavApptDate,
    FV.ctca_appointmentresults__c AS ApptResults,
    (FV.ctca_1sttxdate__c) AS '1stTxDate',
    FV.ctca_scheduledon__c AS ScheduledOn,
    ObjOpportunity.Intake_Type__c AS IntakeType,
    ObjOpportunity.COH_Referral__c AS CoHReferral,
    Account.EPIC_medicalrecordnumber__c AS EpicMRN,
    Contacts.Patient_Status__c AS PatientStatus
FROM
    [Opportunity_Salesforce] ObjOpportunity
    LEFT JOIN [_ListSubscribers] AllSubscribers ON (
        ObjOpportunity.ContactId__c = AllSubscribers.SubscriberKey
        AND AllSubscribers.ListID = 24
    )
    INNER JOIN [Contact_Salesforce] Contacts ON ObjOpportunity.ContactId__c = Contacts.Id
    LEFT JOIN Account_Salesforce Account ON Contacts.AccountId = Account.Id
    INNER JOIN [Facility_Visits__c_Salesforce] FV ON ObjOpportunity.Id = FV.Opportunity__c
    INNER JOIN [Facilities__c_Salesforce] Facility ON (FV.ctca_facilityid__c = Facility.Id)
    LEFT JOIN [Cancer_Type_Mapping_DE_Journey] CancerMapping ON (
        ObjOpportunity.Cancer_Type__c = CancerMapping.CancerType
    )
WHERE
    (FV.ctca_apptstatus__c LIKE 'Scheduled')
    AND (
        FV.ctca_apptdate__c <= DATEADD(DAY, -14, GETDATE())
    )
    AND (
        (
            (
                ObjOpportunity.Insurance_Category__c NOT LIKE '%3%'
            )
            AND (
                FV.ctca_apptdate__c >= DATEADD(YEAR, -1, GETDATE())
            )
        )
        OR (
            (ObjOpportunity.Insurance_Category__c LIKE '%3%')
            AND (
                FV.ctca_apptdate__c >= DATEADD(DAY, -180, GETDATE())
            )
        )
    )
    AND (FV.ctca_1sttxdate__c IS NULL)
    AND (
        (FV.ctca_appointmentresults__c LIKE '%OFU%')
        OR (FV.ctca_appointmentresults__c LIKE '%Follow up%')
        OR (
            FV.ctca_appointmentresults__c LIKE '%NR-3.04 Unwilling to travel%'
        )
        OR (
            FV.ctca_appointmentresults__c LIKE '%NQP-1.12 Second Opinion given%'
        )
        OR (
            FV.ctca_appointmentresults__c LIKE '%NR-5.01 Patient not responding%'
        )
        OR (
            FV.ctca_appointmentresults__c LIKE '%NQP-1.13 Selecting Treatment Elsewhere%'
        )
        OR (
            FV.ctca_appointmentresults__c LIKE '%NQP-1.11 Patient Choosing no Treatment%'
        )
        OR (
            FV.ctca_appointmentresults__c LIKE '%NR-1.02 Not satisfied with personal connection%'
        )
        OR (
            FV.ctca_appointmentresults__c LIKE '%NQP-1.03 Patient disagreed with treatment plan%'
        )
        OR (
            FV.ctca_appointmentresults__c LIKE '%NR-9.03 Other%'
        )
        OR (
            FV.ctca_appointmentresults__c LIKE '%NQP-1.06 Unable to accommodate all%'
        )
        OR (
            FV.ctca_appointmentresults__c LIKE '%NR-5 Communication & Engagement%'
        )
        OR (
            FV.ctca_appointmentresults__c LIKE '%NR-5.02 Lack of consistent communication%'
        )
    )
    AND (
        ObjOpportunity.StageName NOT IN ('Insurance Denied', 'Closed Lost', 'Treated')
    )
    AND (
        ObjOpportunity.Insurance_Category__c NOT LIKE '%7%'
    )
    /*AND (ObjOpportunity.Insurance_Category__c NOT LIKE '%3%')*/
    AND ObjOpportunity.Owner_Profile_Name__c IN (
        'NPES',
        'Scheduler',
        'Patient Advocate',
        'Facilitator',
        'Super Advocate Pilot',
        'Advocate Manager',
        'Empowerment Manager',
        'Virtual Service Advocate',
        'Government Service Center'
    )
    AND (
        (ObjOpportunity.Intake_Type__c IS NULL)
        OR (ObjOpportunity.Intake_Type__c = 'Oncology')
    )
    AND (
        ObjOpportunity.Purpose_of_call__c IS NULL
        OR ObjOpportunity.Purpose_of_call__c NOT IN ('Non-Oncology')
    )
    AND (ObjOpportunity.Email__c IS NOT NULL)
    AND (ObjOpportunity.Email__c NOT LIKE '%@dmctca.com%')
    AND Facility.Name IN ('MRMC', 'SERMC', 'WRMC')
    AND (ObjOpportunity.Cancer_Type__c IS NOT NULL)
    AND (ObjOpportunity.Lead_Score__c > (10))
    AND (
        ObjOpportunity.COH_Referral__c IS NULL
        OR ObjOpportunity.COH_Referral__c != 'Offered/Accepted'
    )
    AND (
        ObjOpportunity.RecordTypeId = '0121C000001RL6JQAW'
    )
    AND (ObjOpportunity.Contact_Status__c IS NULL)
    AND (
        (Contacts.ctca_newstage__c IS NULL)
        OR (
            Contacts.ctca_newstage__c NOT IN ('Expired', 'Hospice')
        )
    )
    AND (Account.Expired__c NOT LIKE '1')
    AND (Contacts.HealthCloudGA__DeceasedDate__c IS NULL)
    AND (Contacts.HasOptedOutOfEmail NOT LIKE '1')
    AND (
        (ObjOpportunity.Nurture_Preference__c IS NULL)
        OR (
            ObjOpportunity.Nurture_Preference__c NOT IN ('Declined')
        )
    )
    AND (
        (ObjOpportunity.Nurture_Status__c IS NULL)
        OR (
            ObjOpportunity.Nurture_Status__c NOT IN ('Declined')
        )
    )
    AND (
        Contacts.donotbulkpostalmail__c IS NULL
        OR Contacts.donotbulkpostalmail__c != 'Do not Allow'
    )
    AND (
        Contacts.Nurture_Status__c IS NULL
        OR Contacts.Nurture_Status__c != 'Declined'
    )
    /*AND (Contacts.Nurture_Preference__c IS NULL or Contacts.Nurture_Status__c != 'Declined')*/
    AND (ObjOpportunity.Name NOT LIKE '%unk%')
    AND (ObjOpportunity.Name NOT LIKE '%delete%')
    AND (
        ObjOpportunity.Owner_Email__c NOT IN (
            'brian.shannon@ctca-hope.com',
            'cherie.fiedler@ctca-hope.com',
            'karen.rivera@ctca-hope.com',
            'kathleen.oates@ctca-hope.com',
            'lorena.hurtadoseverino@ctca-hope.com',
            'matt.owen@ctca-hope.com',
            'matthew.steuart@ctca-hope.com',
            'phyllis.weldon@ctca-hope.com'
        )
    )
    /*for  CF sends only: */
    AND Contacts.ctca_iscancerfighter__c IS NULL
