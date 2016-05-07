/*global cordova, module*/

module.exports = {
    get: function (name, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "Coap", "get", [name]);
    },
    post: function (name, options, successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "Coap", "post", [name, options]);
    },
    test: function (successCallback, errorCallback) {
        cordova.exec(successCallback, errorCallback, "Coap", "test");
    }
};
