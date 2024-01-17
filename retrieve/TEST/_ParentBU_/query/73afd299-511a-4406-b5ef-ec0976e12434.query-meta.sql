SELECT
    TOP 1
WITH
    TIES subFV.Id AS FV_ID,
    subFV.ctca_apptstatus__c AS ApptStatus,
    subFV.ctca_apptdate__c AS ApptDate,
    subFV.ctca_scheduledon__c AS ScheduledOnDate,
    subFV.ctca_reasonforcancel__c AS ReasonForCancel,
    subFV.cancellation_reason_code__c AS CancelReasonCode,
    subFV.ctca_cancelledwhen__c AS CancelledOnDate,
    subFV.ctca_1sttxdate__c AS '1stTxDate',
    subFV.ctca_appointmentresults__c AS Results,
    subFV.Opportunity__c AS OpportunityID,
    subFV.ctca_contactid__c AS ContactID
FROM
    [Facility_Visits__c_Salesforce] subFV
WHERE
    subFV.ctca_apptstatus__c != 'Appt Entry Error'
    AND subFV.ctca_apptdate__c > '2018-11-01'
ORDER BY
    ROW_NUMBER() OVER (
        PARTITION BY
            subFV.ctca_contactid__c
        ORDER BY
            subFV.ctca_scheduledon__c DESC
    )
