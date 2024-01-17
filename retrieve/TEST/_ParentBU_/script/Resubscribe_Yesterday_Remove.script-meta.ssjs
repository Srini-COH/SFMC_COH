Platform.Load('Core', '1.1.1');

var deleteEmails = DataExtension.Init('Resubscribe_Yesterday_Import');
var data = deleteEmails.Rows.Retrieve();

for (var i = 0; i < data.length; i++) {
    var email = data[i].Email;

    var deleteRow = Platform.Function.DeleteData(
        'CoH_Unsubscribes_Auto_Suppression',
        ['Email Address'],
        [email]
    );
}
