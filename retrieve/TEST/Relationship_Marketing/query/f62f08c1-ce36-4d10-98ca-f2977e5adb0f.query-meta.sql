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
    L.Cancer_Status__c AS CancerStatus,
    L.Patient_Gender__c AS Gender,
    L.DMA__c AS DMA,
    AllSubscribers.Status AS SubscriptionStatus,
    CASE
        WHEN L.DMA__c IN ('Atlanta', 'Columbus-Opelika (GA-AL)', 'Macon') THEN 'Atlanta'
        WHEN L.DMA__c IN ('Chicago', 'Milwuakee', 'Rockford') THEN 'Chicago'
        WHEN L.DMA__c IN (
            'Phoenix (Prescott)',
            'Tucson (Sierra Vista)',
            'Yuma-El Centro'
        ) THEN 'Phoenix'
        WHEN L.DMA__c IN ('Los Angeles') THEN 'Los Angeles'
    END AS NearbyHospital
FROM
    ENT.Lead_Salesforce L
    LEFT JOIN ENT._ListSubscribers AllSubscribers ON (
        L.Id = AllSubscribers.SubscriberKey
        AND AllSubscribers.ListID = 24
    )
    LEFT JOIN ENT.RelationshipMktg_Unengaged_Exclusion_Filtered_DE UnEngaged ON L.Id = UnEngaged.SubscriberKey
WHERE
    L.RMT_Opt_In_Status__c = 'Double Opt In'
    AND L.Last_RMT_Start_Date__c IS NOT NULL
    AND L.Email IS NOT NULL
    AND L.IsConverted = '0'
    AND L.Convert_Lead__c = '0'
    AND L.Contact_Status__c IS NULL
    AND (L.HasOptedOutOfEmail NOT LIKE '1')
    AND (
        (L.Nurture_Status__c IS NULL)
        OR (L.Nurture_Status__c NOT IN ('Declined'))
    )
    AND AllSubscribers.Status = 'Active'
    AND UnEngaged.SubscriberKey IS NULL
    AND (
        (
            L.Cancer_Status_Risk_Assessment__c = 'Currently diagnosed with cancer'
        )
        OR (
            L.Cancer_Status_Risk_Assessment__c = 'Have had cancer in the past'
        )
        OR (
            L.Cancer_Status_Risk_Assessment__c = 'Never been diagnosed with cancer'
        )
    )
    /*
    AND (
    (L.Cancer_Status_Risk_Assessment__c = 'Currently diagnosed with cancer') 
    OR 
    (L.Cancer_Status_Risk_Assessment__c = 'Have had cancer in the past')
    OR 
    (L.Cancer_Status_Risk_Assessment__c = 'Never been diagnosed with cancer')
    )
    */
    /*AND (DATEDIFF(dd, L.Last_RMT_Start_Date__c AT TIME ZONE 'Central Standard Time', GetDate() AT TIME ZONE 'Central Standard Time') < 365)
    */
    /*
    AND (
    DATEDIFF(dd, L.Last_RMT_Completed_Date__c AT TIME ZONE 'Central Standard Time', GetDate() AT TIME ZONE 'Central Standard Time') >= 2 
    OR (L.Last_RMT_Completed_Date__c IS NULL
    AND (DATEDIFF(dd, L.Last_RMT_Start_Date__c AT TIME ZONE 'Central Standard Time', GetDate() AT TIME ZONE 'Central Standard Time') > 7))
    )
    AND L.FirstName = 'RMTTest'*/
