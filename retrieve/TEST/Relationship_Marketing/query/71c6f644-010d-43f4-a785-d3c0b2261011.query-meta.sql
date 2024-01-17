SELECT
    L.Id AS SubscriberKey,
    L.FirstName AS FirstName,
    L.Email AS Email,
    L.Last_RMT_Start_Date__c AS Last_RMT_Start_Date,
    L.Last_RMT_Completed_Date__c AS Last_RMT_Completed_Date,
    CASE
        WHEN L.Last_RMT_Completed_Date__c IS NOT NULL THEN 'True'
        WHEN L.Last_RMT_Completed_Date__c IS NULL THEN 'False'
    END AS RMT_Completed,
    L.IsConverted AS Converted,
    CASE
        WHEN L.RecordTypeId = '0121C000001pMVWQA2' THEN 'Risk Assessment'
        WHEN L.RecordTypeId = '0121C000001RL6FQAW' THEN 'Empowerment'
    END AS LeadRecordType,
    L.RMT_Opt_In_Status__c AS RMTOptInStatus,
    L.Cancer_Status_Risk_Assessment__c AS RMTCancerStatus,
    L.Cancer_Status__c AS CancerStatus
FROM
    ENT.Lead_Salesforce L
WHERE
    L.RMT_Opt_In_Status__c = 'Double Opt In'
    AND L.Last_RMT_Start_Date__c IS NOT NULL
    AND L.IsConverted = '0'
    AND L.Contact_Status__c IS NULL
    AND (L.HasOptedOutOfEmail NOT LIKE '1')
    AND (
        (L.Nurture_Status__c IS NULL)
        OR (L.Nurture_Status__c NOT IN ('Declined'))
    )
    AND (L.Lead_Score__c > (10))
    AND (
        (
            DATEDIFF(
                dd,
                L.Last_RMT_Completed_Date__c AT TIME ZONE 'Central Standard Time',
                GETDATE() AT TIME ZONE 'Central Standard Time'
            ) >= 2
            OR (
                L.Last_RMT_Completed_Date__c IS NULL
                AND (
                    DATEDIFF(
                        dd,
                        L.Last_RMT_Start_Date__c AT TIME ZONE 'Central Standard Time',
                        GETDATE() AT TIME ZONE 'Central Standard Time'
                    ) > 7
                )
            )
        )
        OR (
            L.Cancer_Status_Risk_Assessment__c LIKE 'Currently diagnosed with cancer'
            AND (
                DATEDIFF(
                    dd,
                    L.Last_RMT_Start_Date__c AT TIME ZONE 'Central Standard Time',
                    GETDATE() AT TIME ZONE 'Central Standard Time'
                ) >= 2
            )
        )
    )
    /*AND L.FirstName = 'RMTTest'*/
