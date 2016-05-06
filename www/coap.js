/*global cordova*/

var exec = require("cordova/exec");

var Coap = function(){};

Coap.prototype.greet = function (name, successCallback, errorCallback) {
    cordova.exec(successCallback, errorCallback, "Coap", "get", [name]);
};

module.exports = new Coap();
