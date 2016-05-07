
import Foundation

@objc(HWCoapPlugin) class Coap : CDVPlugin {
    func get(command: CDVInvokedUrlCommand) {

        let m = SCMessage(code: SCCodeValue(classValue: 0, detailValue: 01)!, type: .Confirmable, payload: "test".dataUsingEncoding(NSUTF8StringEncoding))

        m.addOption(SCOption.UriPath.rawValue, data: "test".dataUsingEncoding(NSUTF8StringEncoding)!)

        let coapClient = SCClient()
        coapClient.sendCoAPMessage(m, hostName: "coap.me", port: 5683)

        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAsString: "Hello World")
        commandDelegate.sendPluginResult(pluginResult, callbackId:command.callbackId)
    }
    func test(command: CDVInvokedUrlCommand) {

        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAsString: "Hello World")
        commandDelegate.sendPluginResult(pluginResult, callbackId:command.callbackId)
    }
}
