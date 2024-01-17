SELECT DISTINCT
    ObjOpportunity.Id AS OppId,
    ObjOpportunity.ContactId__c AS ContactID,
    ObjOpportunity.AccountId AS AccountID,
    ObjOpportunity.Nurture_Status__c AS ONurtureStatus,
    Contacts.Nurture_Status__c AS CNurtureStatus,
    ObjOpportunity.Nurture_Preference__c AS ONurturePreference,
    ObjOpportunity.Nurture_Last_Sent__c AS ONurtureLastSent,
    ObjOpportunity.Topics_Sent__c AS OTopicsSent,
    ObjOpportunity.CreatedDate AS OCreatedDate,
    ObjOpportunity.Contact_Status__c AS OContactStatus,
    Facility.Name AS OSelectedFacility,
    ObjOpportunity.StageName AS OStage
FROM
    [Opportunity_Salesforce] ObjOpportunity
    INNER JOIN [Contact_Salesforce] Contacts ON ObjOpportunity.ContactId__c = Contacts.Id
    LEFT JOIN [Facilities__c_Salesforce] Facility ON (ObjOpportunity.Selected_Facility__c = Facility.Id)
WHERE
    (
        (
            ObjOpportunity.Nurture_Status__c IN ('Declined', 'Enrolled')
        )
        OR (
            Contacts.Nurture_Status__c IN ('Declined', 'Enrolled')
        )
        OR (
            ObjOpportunity.Nurture_Preference__c IN ('Declined', 'Subscribe')
        )
        OR (ObjOpportunity.Nurture_Last_Sent__c IS NOT NULL)
        OR (ObjOpportunity.Topics_Sent__c IS NOT NULL)
    )
    AND (
        (ObjOpportunity.Contact_Status__c IS NULL)
        OR (
            ObjOpportunity.Contact_Status__c != 'Duplicate Record'
        )
    )
