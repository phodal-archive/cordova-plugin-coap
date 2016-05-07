
import Foundation

@objc(HWCoapPlugin) class Coap : CDVPlugin {
    let separatorLine = "\n-----------------\n"

    func get(command: CDVInvokedUrlCommand) {

        let m = SCMessage(code: SCCodeValue(classValue: 0, detailValue: 01)!, type: .Confirmable, payload: "test".dataUsingEncoding(NSUTF8StringEncoding))

        m.addOption(SCOption.UriPath.rawValue, data: "test".dataUsingEncoding(NSUTF8StringEncoding)!)

        let coapClient = SCClient(delegate: self)
        coapClient.sendCoAPMessage(m, hostName: "coap.me", port: 5683)

        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAsString: "Hello World")
        commandDelegate.sendPluginResult(pluginResult, callbackId:command.callbackId)
    }
    func test(command: CDVInvokedUrlCommand) {

        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAsString: "Hello World")
        commandDelegate.sendPluginResult(pluginResult, callbackId:command.callbackId)
    }
}

extension Coap: SCClientDelegate {
    func swiftCoapClient(client: SCClient, didReceiveMessage message: SCMessage) {
        var payloadstring = ""
        if let pay = message.payload {
            if let string = NSString(data: pay, encoding:NSUTF8StringEncoding) {
                payloadstring = String(string)
            }
        }
        _ = "Message received with type: \(message.type.shortString())\nwith code: \(message.code.toString()) \nwith id: \(message.messageId)\nPayload: \(payloadstring)"
        var optString = "Options:\n"
        for (key, _) in message.options {
            var optName = "Unknown"

            if let knownOpt = SCOption(rawValue: key) {
                optName = knownOpt.toString()
            }

            optString += "\(optName) (\(key))"
        }
    }

    func swiftCoapClient(client: SCClient, didFailWithError error: NSError) {

    }

    func swiftCoapClient(client: SCClient, didSendMessage message: SCMessage, number: Int) {

    }
}
