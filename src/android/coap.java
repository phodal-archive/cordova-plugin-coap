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
    CallbackContext syncCB, asyncCB;

    @Override
    public boolean execute(String action, JSONArray data, CallbackContext callbackContext) throws JSONException {
        if (action.equals("get")) {
            this.syncCB = callbackContext;
            Log.i("get ", "\n test for get");

            try {
                URI uri = new URI("coap://192.168.31.170/");
                CoapClient mCoapClient = new CoapClient(uri);
                CoapResponse response = mCoapClient.get();
                syncCB.success(response.getResponseText() + "=============");
            } catch (URISyntaxException e) {
                syncCB.error("URISyntaxException");
            } catch (Exception e) {
                syncCB.error("Exception");
            }

            return true;
        } else if (action.equals("test"))

        {
            Log.i("test", "\n test for test");
            callbackContext.success("test");
            return true;
        } else

        {
            return false;
        }
    }
}
