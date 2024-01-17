Platform.Load('Core', '1.1.5');

var dataExtensionName = '20231115_AllSubscribers_Status_Fix'; // Your Data Extension Name
var deRows = DataExtension.Init(dataExtensionName).Rows.Retrieve();
var prox = new Script.Util.WSProxy();
var subArr = [];

for (var i = 1; i < deRows.length; i++) {
    var subObj = {
        SubscriberKey: deRows[i].SubscriberKey,
        EmailAddress: deRows[i].Email, // Assuming there is an 'Email' field in your DE
        Lists: [
            {
                ID: '24', // Your specific List ID
                Status: 'Unsubscribed'
            }
        ]
    };
    subArr.push(subObj);
}

var options = {
    SaveOptions: [
        {
            PropertyName: '*',
            SaveAction: 'UpdateAdd'
        }
    ]
};

try {
    var updateResult = prox.updateBatch('Subscriber', subArr, options);
    // Optional: Log or handle the updateResult as needed
    // Write(Stringify(updateResult));
} catch (e) {
    // Error handling
    Write('Error: ' + Stringify(e));
}
