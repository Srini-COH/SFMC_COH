Platform.Load('Core', '1.1');

var OpportunityReferenceDE_Auto_Testing = DataExtension.Init('Resource_Request__c_Salesforce');
var result = OpportunityReferenceDE_Auto_Testing.Rows.Update(
    { ContactId: 'ContactId__c' },
    ['ContactId'],
    ['0032405071zljdyAAA']
);

Write('<b>Output:</b>' + result);
