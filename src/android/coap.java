package com.phodal.plugin;

import org.apache.cordova.*;

import org.json.JSONArray;
import org.json.JSONException;


public class Coap extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray data, CallbackContext callbackContext) throws JSONException {
        if (action.equals("get")) {
            callbackContext.success("get");
            return true;
        } else if (action.equals("test")) {
            callbackContext.success("test");
            return true;
        } else {
            return false;
        }
    }
}
