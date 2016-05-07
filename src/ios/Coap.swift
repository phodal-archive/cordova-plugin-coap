
import Foundation

 @objc(HWCoapPlugin) class Coap : CDVPlugin {
    func get(command: CDVInvokedUrlCommand) {

        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAsString: "Hello World")
        commandDelegate.sendPluginResult(pluginResult, callbackId:command.callbackId)
    }
    func test(command: CDVInvokedUrlCommand) {

        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAsString: "Hello World")
        commandDelegate.sendPluginResult(pluginResult, callbackId:command.callbackId)
    }
}
