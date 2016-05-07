package com.phodal.plugin;

import org.apache.cordova.*;
import org.eclipse.californium.core.CoapClient;
import org.eclipse.californium.core.CoapResponse;
import org.json.JSONArray;
import org.json.JSONException;

import android.util.Log;

import java.net.URI;
import java.net.URISyntaxException;

public class Coap extends CordovaPlugin {

    @Override
    public boolean execute(String action, JSONArray data, CallbackContext callbackContext) throws JSONException {
        if (action.equals("get")) {
            Log.d("Coap ", "\n test for get");

            try {
                URI uri = new URI("coap://192.168.31.170/");
                CoapClient mCoapClient = new CoapClient(uri);
                CoapResponse response = mCoapClient.get();
                callbackContext.success(response.getResponseText() + "=============");
                return true;
            } catch (URISyntaxException e) {
                Log.e("Coap", "URISyntaxException");
                callbackContext.error("URISyntaxException");
                return false;
            } catch (Exception e) {
                Log.e("Coap", "Exception");
                callbackContext.error("Exception");
                return false;
            }
        } else if (action.equals("test"))

        {
            Log.d("Coap", "\n test for test");
            callbackContext.success("test");
            return true;
        } else {
            return false;
        }
    }
}
