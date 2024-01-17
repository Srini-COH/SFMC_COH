SELECT
    ObjOpportunity.Id AS OpportunityId,
    ObjOpportunity.Name AS Name,
    Contacts.FirstName AS FirstName,
    ObjOpportunity.ContactId__c AS ContactId,
    ObjOpportunity.StageName AS Stage,
    ObjOpportunity.Last_Stage__c AS LastStage,
    ObjOpportunity.Email__c AS Email,
    Facility.Name AS SelectedFacility,
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
    ObjOpportunity.COH_Referral__c AS CoHReferral,
    ObjOpportunity.Nurture_Last_Sent__c AS NurtureLastSent,
    ObjOpportunity.Topics_Sent__c AS TopicsSent,
    /*No longer used:
    ObjOpportunity.Nurture_Message_Counter__c as MessageCounter,
    ObjOpportunity.Nurture_Tile1_Counter__c as Tile1Counter,
    ObjOpportunity.Nurture_Tile2_Counter__c as Tile2Counter,
    ObjOpportunity.Nurture_Tile3_Counter__c as Tile3Counter,
    ObjOpportunity.Segment_Tag_Terms__c as SegmentTagTerms,
    ObjOpportunity.Direct_Mailable__c as DirectMailable,
    ObjOpportunity.Owner_Address__c as OwnerAddress,
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
    FV.ctca_reasonforcancel__c AS ReasonForCancel,
    FV.cancellation_reason_code__c AS CancellationReasonCode,
    FV.ctca_cancelledwhen__c AS CancellationDate,
    FV.Appointment_Type__c AS ApptType,
    ObjOpportunity.RecordTypeId AS OppRecordType,
    Account.EPIC_medicalrecordnumber__c AS EpicMRN
FROM
    [Opportunity_Salesforce] ObjOpportunity
    LEFT JOIN [_ListSubscribers] AllSubscribers ON ObjOpportunity.ContactId__c = AllSubscribers.SubscriberKey
    LEFT JOIN [Facilities__c_Salesforce] Facility ON (ObjOpportunity.Selected_Facility__c = Facility.Id)
    INNER JOIN [Contact_Salesforce] Contacts ON ObjOpportunity.ContactId__c = Contacts.Id
    LEFT JOIN Account_Salesforce Account ON Contacts.AccountId = Account.Id
    INNER JOIN (
        SELECT
            TOP 1
        WITH
            TIES subFV.Opportunity__c,
            subFV.ctca_apptstatus__c,
            subFV.ctca_apptdate__c,
            subFV.Cancellation_Risk_Score__c,
            subFV.Days_Between_Appt_and_Appt_Scheduled__c,
            subFV.NN_Appointment_Date__c,
            subFV.ctca_appointmentresults__c,
            (subFV.ctca_1sttxdate__c),
            subFV.ctca_scheduledon__c,
            subFV.ctca_reasonforcancel__c,
            subFV.cancellation_reason_code__c,
            subFV.ctca_cancelledwhen__c,
            subFV.Appointment_Type__c
        FROM
            [Facility_Visits__c_Salesforce] subFV
        WHERE
            subFV.ctca_apptstatus__c != 'Appt Entry Error'
        ORDER BY
            ROW_NUMBER() OVER (
                PARTITION BY
                    subFV.ctca_contactid__c
                ORDER BY
                    subFV.ctca_scheduledon__c DESC
            )
    ) FV ON ObjOpportunity.Id = FV.Opportunity__c
    LEFT JOIN [Cancer_Type_Mapping_DE_Journey] CancerMapping ON (
        ObjOpportunity.Cancer_Type__c = CancerMapping.CancerType
    )
WHERE
    (FV.ctca_apptstatus__c = 'Canceled')
    AND (
        (
            (
                ObjOpportunity.Insurance_Category__c NOT LIKE '%3%'
            )
            AND (
                FV.ctca_apptdate__c >= DATEADD(DAY, -360, GETDATE())
            )
        )
        OR (
            (ObjOpportunity.Insurance_Category__c LIKE '%3%')
            AND (
                FV.ctca_apptdate__c >= DATEADD(DAY, -180, GETDATE())
            )
        )
    )
    /*For holiday send, Joy requested all cancelations receive. Normal rule is:   */
    AND (
        FV.ctca_cancelledwhen__c <= DATEADD(DAY, -30, GETDATE())
    )
    AND (
        FV.ctca_cancelledwhen__c <= DATEADD(DAY, -1, GETDATE())
    )
    AND (FV.ctca_1sttxdate__c IS NULL)
    AND (FV.ctca_appointmentresults__c IS NULL)
    AND FV.ctca_reasonforcancel__c NOT IN (
        'GSC - Clinical qualification criteria',
        'Payment options / Financial Assistance'
    )
    AND FV.ctca_reasonforcancel__c NOT LIKE ('Payment options')
    AND (
        (FV.cancellation_reason_code__c IS NULL)
        OR (
            FV.cancellation_reason_code__c NOT IN (
                'CTCA continues to change my schedule',
                'Too many handoffs / no single point of contact',
                'CTCA declines financially',
                'ECOG',
                'Expired',
                'Hospice',
                'Hospitalized locally',
                'No active cancer',
                'No Tx options left',
                'Patient too sick to tolerate treatment or travel (patient reported)',
                'Medical Record Review in progress'
            )
        )
    )
    AND (
        ObjOpportunity.StageName NOT IN (
            'Insurance Denied',
            /*'Closed Lost',*/ 'Treated',
            'Appointment Kept',
            'Appointment Made'
        )
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
        ObjOpportunity.Purpose_of_call__c IS NULL
        OR ObjOpportunity.Purpose_of_call__c NOT IN ('Non-Oncology')
    )
    AND (
        ObjOpportunity.Intake_Type__c IS NULL
        OR ObjOpportunity.Intake_Type__c = 'Oncology'
    )
    /*Consider adding Appointment Type is not Telehealth*/
    AND (ObjOpportunity.Email__c IS NOT NULL)
    AND (ObjOpportunity.Email__c NOT LIKE '%@dmctca.com%')
    AND (
        (Facility.Name IS NULL)
        OR (Facility.Name IN ('MRMC', 'SERMC', 'WRMC'))
    )
    AND (ObjOpportunity.Cancer_Type__c IS NOT NULL)
    AND (ObjOpportunity.Lead_Score__c > (10))
    AND (ObjOpportunity.Contact_Status__c IS NULL)
    AND (
        Contacts.ctca_newstage__c NOT IN ('Expired', 'Hospice')
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
    AND (ObjOpportunity.Name NOT LIKE '%unk%')
    AND (ObjOpportunity.Name NOT LIKE '%delete%')
    AND (
        ObjOpportunity.RecordTypeId = '0121C000001RL6JQAW'
    )
    AND (
        ObjOpportunity.COH_Referral__c IS NULL
        OR ObjOpportunity.COH_Referral__c != 'Offered/Accepted'
    )
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
