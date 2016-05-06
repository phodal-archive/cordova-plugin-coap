package com.phodal.plugin.coap;

import org.apache.cordova.*;

import org.json.JSONArray;
import org.json.JSONException;

import org.eclipse.californium.core.CoapClient;
import org.eclipse.californium.core.CoapResponse;

import java.net.URI;
import java.net.URISyntaxException;


public class Coap extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray data, CallbackContext callbackContext) throws JSONException, URISyntaxException {

        if (action.equals("get")) {
            try {
                URI uri = new URI("coap://iot.eclipse.org:5683/");
                CoapClient mCoapClient = new CoapClient(uri);
                CoapResponse response = mCoapClient.get();

                callbackContext.success(response);
                return true;
            } catch (Exception e) {

            }

        } else {
            return false;

        }
    }
}
