
import Foundation

@objc(HWCoapPlugin) class Coap : CDVPlugin {
    var syncMessage = ""
    let separatorLine = "\n-----------------\n"

    func get(command: CDVInvokedUrlCommand) {

        let m = SCMessage(code: SCCodeValue(classValue: 0, detailValue: 01)!, type: .Confirmable, payload: "test".dataUsingEncoding(NSUTF8StringEncoding))

        m.addOption(SCOption.UriPath.rawValue, data: "test".dataUsingEncoding(NSUTF8StringEncoding)!)

        let coapClient = SCClient(delegate: self)
        coapClient.sendCoAPMessage(m, hostName: "192.168.31.170", port: 5683)

        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAsString: syncMessage)
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
        syncMessage = payloadstring
    }

    func swiftCoapClient(client: SCClient, didFailWithError error: NSError) {
        syncMessage = "Failed with Error \(error.localizedDescription)" + separatorLine + separatorLine
    }

    func swiftCoapClient(client: SCClient, didSendMessage message: SCMessage, number: Int) {
//        syncMessage =  "Message sent (\(number)) with type: \(message.type.shortString()) with id: \(message.messageId)\n" + separatorLine + separatorLine
        syncMessage = "Message Sent"
    }
}
