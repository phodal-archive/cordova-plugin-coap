package com.phodal.plugin;

import org.apache.cordova.*;

import org.json.JSONArray;
import org.json.JSONException;

import org.eclipse.californium.core.CoapClient;
import org.eclipse.californium.core.CoapResponse;

import java.net.URI;
import java.net.URISyntaxException;
import java.net.UnknownHostException;

public class Coap extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray data, CallbackContext callbackContext) throws JSONException {
        if (action.equals("get")) {
            try {
                URI uri = new URI("coap://vs0.inf.ethz.ch:5683/");
                CoapClient mCoapClient = new CoapClient(uri);
                CoapResponse response = mCoapClient.get();
                callbackContext.success(response.getResponseText());
                return true;
            } catch (URISyntaxException e) {
                return false;
            }
        } else if (action.equals("test")) {
            callbackContext.success("test");
            return true;
        } else {
            return false;
        }
    }
}
