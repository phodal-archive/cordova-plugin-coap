/*global cordova, module*/

module.exports = {
    get: function (name, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "Coap", "get", [name]);
    }
};
