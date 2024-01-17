Platform.Function.ContentBlockByID('77320');
Platform.Load('core', '1.1.1');
var datedifference = Variable.GetValue('@day');
if (datedifference >= 6) {
    var url = 'https://api.rmt.cancercenter.com/api/authenticate';
    var contentType = 'application/json';
    var payload = Stringify({
        username: 'salesforceController',
        password: 'bw7}Z:$5m;@G3FCE'
    });
    var headerNames = ['Encoding'];
    var headerValues = ['utf-8'];
    var result = HTTP.Post(url, contentType, payload, headerNames, headerValues);
    if (result.StatusCode == 200) {
        var tokendata = result.Response[0];
        var resultset = Platform.Function.ParseJSON(tokendata);
        var accesstoken = resultset.token;
        Write(accesstoken);
        Variable.SetValue('@accesstoken', accesstoken);
        Platform.Function.ContentBlockByID('72383');
    }
}
