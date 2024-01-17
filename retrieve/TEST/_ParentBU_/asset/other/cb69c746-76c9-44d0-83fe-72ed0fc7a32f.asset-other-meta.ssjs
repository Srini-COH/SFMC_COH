var scFormLoaded = function () {
    window.ScForm.init({
        gearID: 'jeao5g054yi',
        smartCaptureFormID: 0,
        sourceKey: '26346DC1-A883-4C9A-B837-63BAADE1E64A',
        source: 'default',
        triggeredSend: '',
        confirmationMessage: 'Thank you for your submission.',
        buttonText: 'Submit',
        formStyling: {
            'background-color': 'transparent',
            'margin-top': '0px',
            'margin-right': '0px',
            'margin-bottom': '0px',
            'margin-left': '0px',
            'padding-top': '0px',
            'padding-right': '0px',
            'padding-bottom': '0px',
            'padding-left': '0px',
            'text-align': 'left'
        },
        fieldStyling: { width: '200px' },
        buttonStyling: {
            'background-color': '#009DDC',
            'border-color': '#009DDC',
            'border-radius': '3px',
            'border-style': 'solid',
            '-webkit-border-radius': '3px',
            '-moz-border-radius': '3px',
            color: '#FFFFFF',
            'font-family': 'Arial, Helvetica, sans-serif',
            'font-size': '16px',
            'line-height': 'normal',
            padding: '10px'
        }
    });
};
window.appDomain =
    window.appDomain || '<ctrl:eval>Platform.Variable.GetValue("@appDomain")||""</ctrl:eval>';
window.contentDetail = window.contentDetail || (
    <ctrl:eval>Platform.Variable.GetValue('@contentDetail')||{}</ctrl:eval>
);
if (!window.ScForm || !window.ScForm.init) {
    var head = document.getElementsByTagName('head')[0];
    var id = 'smartcapture-formjs-script';
    var script = document.getElementById(id);
    var domain = window.appDomain;
    var el;
    if (!script) {
        if (domain) {
            domain = '//' + domain;
        }
        el = document.createElement('script');
        el.async = true;
        el.id = id;
        el.src = domain + '/CloudPages/lib/smartcapture-formjs.js';
        el.onload = scFormLoaded;
        head.appendChild(el);
    } else {
        if (script.addEventListener) {
            script.addEventListener('load', scFormLoaded);
        } else if (script.attachEvent) {
            script.attachEvent('onload', scFormLoaded);
        }
    }
} else {
    scFormLoaded();
}
