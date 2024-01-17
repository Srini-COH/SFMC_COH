/**
 * Selects the SubscriberKey field, which contains the Salesforce ID of the contact.
*/
SELECT
    c.Id AS SubscriberKey
FROM
    Excluded_No_Channel d
    INNER JOIN Contact_Salesforce c ON d.SubscriberKey = c.Id
