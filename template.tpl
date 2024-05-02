___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "TAG",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Scoby Analytics",
  "brand": {
    "id": "mbaersch",
    "displayName": "mbaersch",
    "thumbnail": "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACQAAAAkCAYAAADhAJiYAAAABmJLR0QA/wD/AP+gvaeTAAAACXBIWXMAAC4jAAAuIwF4pT92AAAAB3RJTUUH6AUBFCgIDjb2bgAAABl0RVh0Q29tbWVudABDcmVhdGVkIHdpdGggR0lNUFeBDhcAAALYSURBVFjDzZhbSFNxHMe/O5ftLHUX3TKdmnkr8ZKWRAhdXgKJXCyyHvYUQi8hPUQ+REQvvRhhRkVEUESQkigEQRT04INEkGlmbqeR6DTNLdnmnOe4Ww+Fl1abnvN37QcHDud3zu98+PH7/26K8auXokiyUCoV2JxcMMZsMAYj1LV1yzpGHB3B/5DFwYHle3XNXhjPX4SCYUAhBWRx8D0mmq0QHTwU/OnjUaSQUEgxYTb6Aa3LhGrnLnBl5aANWRDtNoi8DaKDTy7Qlto6aMwnoCopW/t8zz4AQNgzh8Dbfni6OxERBclACWNIQdPItJ5B+pGGdRkM++fhvnMTwqch8kB0pgF5HfckGRY+fsD369fIBnV262XJrueqa5Fx1EwOSNtoAWvKkxWg+lNWKAuL5ANRnBoZ64yZRPGntZyUD6QsLgGtzyJyjLmiUvlAquJSkBJKpwdj3CoPiCuvJJp9lXkFMoEqq4kCsYU75AEJdhtRoOCkUx7QEj9KFsg5LtNDPDkPRbweBGem5QGJ/ChCrlkiQKLDLv/YRwIBeLo7ZcNEQyHMPXlEpnQs9PdBGB6SBTTb0YaQ20WuuLrutkuGCQy8g7CqkScCFPH74TzXjCXnxIaMep/3wNXetvITVom0+oPQWpqQfuAwlAXbpTdoqyu3ptESvwey2+Dt7YIwMrySpU35MLRcWNM5RAQBnqePMf/mlXQgAKA1WrC5pl9XYTEYnR7imAPBSSeCU04Ev02tdb9Wh/zbD/5pb/pKK5bGvkpv8sM+L8I+LwTbZwCvE76vbTgWV59WfygGaFPHINaUH1efvr8+uXNZRFyMX1J+uJML9GdMxYzQQ7FpgWJycjcNyNv7DOIXe1x9DBC7zbSpo7Hr1g14eroQ+l1gwz4fFvr7MNly9u95aObh/ajv5YukzO2q8gokWv9Q6pq6pC0S1rOLoriKKmjMltRax+ibrOCqdqcE0E/iyu/PAzbiWQAAAABJRU5ErkJggg\u003d\u003d"
  },
  "description": "Send pageviews to Scoby Analytics",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "GROUP",
    "name": "groupSettings",
    "displayName": "Scoby Settings",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "type": "TEXT",
        "name": "apiKey",
        "displayName": "API Key",
        "simpleValueType": true,
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ],
        "defaultValue": "",
        "help": "Please find your API key in your workspace-settings on https://app.scoby.io"
      },
      {
        "type": "TEXT",
        "name": "salt",
        "displayName": "Secret Salt",
        "simpleValueType": true,
        "help": "The salt helps to anonymize your traffic before it is sent to our servers. It must be an alphanumeric string of at least 32 characters. You can generate one on e.g. https://onlinetools.com/random/generate-random-string",
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          }
        ]
      },
      {
        "type": "TEXT",
        "name": "timeout",
        "displayName": "Timeout (ms)",
        "simpleValueType": true,
        "defaultValue": 5000,
        "valueValidators": [
          {
            "type": "NON_EMPTY"
          },
          {
            "type": "POSITIVE_NUMBER"
          }
        ]
      }
    ]
  },
  {
    "displayName": "Logs Settings",
    "name": "logsGroup",
    "groupStyle": "ZIPPY_CLOSED",
    "type": "GROUP",
    "subParams": [
      {
        "type": "RADIO",
        "name": "logType",
        "radioItems": [
          {
            "value": "no",
            "displayValue": "Do not log"
          },
          {
            "value": "debug",
            "displayValue": "Log to console during debug and preview"
          },
          {
            "value": "always",
            "displayValue": "Always log to console"
          }
        ],
        "simpleValueType": true,
        "defaultValue": "debug"
      }
    ]
  }
]


___SANDBOXED_JS_FOR_SERVER___

/**
 * @description Custom server-side Google Tag Manager Tag Template
 * Send events to Scoby Analytics
 * @version 1.0.1
 * @see {@link https://github.com/mbaersch|GitHub} for more info
 * @see {@link https://scoby.io/|Scoby Homepage}
 */

const getRemoteAddress = require('getRemoteAddress');
const sha256Sync = require('sha256Sync');
const fromBase64 = require('fromBase64');
const parseUrl = require('parseUrl');
const encodeUriComponent = require('encodeUriComponent');
const getAllEventData = require('getAllEventData');
const sendHttpRequest = require('sendHttpRequest');
const JSON = require('JSON');
const getRequestHeader = require('getRequestHeader');
const makeString = require('makeString');
const getContainerVersion = require('getContainerVersion');
const logToConsole = require('logToConsole');

/****************************************************************/

function cleanupRequestedUrl(qurl) {
  const url = parseUrl(qurl);
  const queryParams = [];
  for(const param in ['utm_source', 'utm_medium', 'utm_campaign', 'utm_term', 'utm_content']) {
    if(url.searchParams[param]) {
      queryParams.push(param + '=' + encodeUriComponent(url.searchParams[param]));
    }
  }
  let res = url.origin + url.pathname;
  if (queryParams.length > 0) res += '?' + queryParams.join('&'); 
    return res; 
}

function determinateIsLoggingEnabled() {
  const containerVersion = getContainerVersion();
  const isDebug = !!(
      containerVersion &&
      (containerVersion.debugMode || containerVersion.previewMode)
  );

  if (!data.logType) return isDebug;
  if (data.logType === 'no') return false;
  if (data.logType === 'debug') return isDebug;
  return data.logType === 'always';
}

const stpLog = function(tp, en, prms) {   
  if (isLoggingEnabled) {
    var ob = {
        Name: 'Scoby',
        Type: tp,
        TraceId: traceId,
        EventName: makeString(en),
    };
    
    if (tp === "Request") {        
        ob.RequestMethod = prms.method;
        ob.RequestUrl = serviceUrl;
    } else {
        ob.ResponseStatusCode = prms.statusCode;
        ob.ResponseHeaders = prms.headers;
        //ob.ResponseBody = prms.body;
    }
    logToConsole(JSON.stringify(ob));
  }
};

/****************************************************************/

const isLoggingEnabled = determinateIsLoggingEnabled();
const traceId = getRequestHeader('trace-id');

const eventData = getAllEventData();
const url = eventData.page_location;
const decodedKey = fromBase64(data.apiKey)||"";
var serviceUrl;

if (!decodedKey.indexOf("|")) {
  logToConsole("EVENT NOT SENT! Key is not valid.");
  data.gtmOnFailure();
} else if (url) {
  const apiKey = 'Bearer ' + decodedKey.split('|')[1];
  const appId = decodedKey.split('|')[0];
  const userAgent = eventData.user_agent || getRequestHeader("user-agent");
  const visitorId = sha256Sync([
                       getRemoteAddress(), 
                       userAgent, 
                       appId, 
                       data.salt
                    ].join('|'), {outputEncoding: 'hex'});
  const requestedUrl = cleanupRequestedUrl(url);
  const referringUrl = eventData.page_referrer;
  
  const params = [];
  params.push('vid=' + encodeUriComponent(visitorId));
  params.push('ua=' + encodeUriComponent(userAgent));
  params.push('url=' + encodeUriComponent(requestedUrl));
  params.push('ref=' + encodeUriComponent(referringUrl));
  
  serviceUrl = 'https://' + appId + '.s3y.io/count?' + params.join('&');
  stpLog('Request', 'page_view', {method: 'GET'});

  sendHttpRequest(
      serviceUrl, (statusCode, headers, body) => {
        stpLog('Response', 'page_view', {statusCode: statusCode, headers: headers, body: body});
        if (statusCode >= 200 && statusCode < 300) data.gtmOnSuccess();
        else data.gtmOnFailure();
      },
      {
        headers: {
          Authorization: apiKey
        },
        method: 'GET',
        timeout: data.timeout||5000
      }
  );

} else
  data.gtmOnFailure();


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_event_data",
        "versionId": "1"
      },
      "param": [
        {
          "key": "eventDataAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "send_http",
        "versionId": "1"
      },
      "param": [
        {
          "key": "allowedUrls",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_request",
        "versionId": "1"
      },
      "param": [
        {
          "key": "requestAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "headerAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queryParameterAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "all"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_container_data",
        "versionId": "1"
      },
      "param": []
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 7.12.2022, 05:01:54


