
import Foundation

func log(message: String){
    NSLog("%@ - %@", "CoAP Plugin", message)
}

func log(messages: [String]) {
    for message in messages {
        log(message);
    }
}

@objc(HWCoapPlugin) class Coap : CDVPlugin {
    var syncMessage = ""
    let separatorLine = "\n-----------------\n"
    var getId = "";

    func get(command: CDVInvokedUrlCommand) {

        let m = SCMessage(code: SCCodeValue(classValue: 0, detailValue: 01)!, type: .Confirmable)

        let coapClient = SCClient(delegate: self)
        coapClient.sendCoAPMessage(m, hostName: command.arguments[0], port: 5683)

        getId = command.callbackId
    }

    func post(command: CDVInvokedUrlCommand) {

        let m = SCMessage(code: SCCodeValue(classValue: 0, detailValue: 01)!, type: .Confirmable, payload: "test".dataUsingEncoding(NSUTF8StringEncoding))

        m.addOption(SCOption.UriPath.rawValue, data: "test".dataUsingEncoding(NSUTF8StringEncoding)!)

        let coapClient = SCClient(delegate: self)
        coapClient.sendCoAPMessage(m, hostName: "192.168.31.170", port: 5683)

        getId = command.callbackId
    }



    func test(command: CDVInvokedUrlCommand) {
        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAsString: "Hello World")
        commandDelegate.sendPluginResult(pluginResult, callbackId:command.callbackId)
    }

    private func notify (message: String) {
        let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAsString: message);
        commandDelegate!.sendPluginResult(pluginResult, callbackId:getId);
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
        self.notify(payloadstring)
    }

    func swiftCoapClient(client: SCClient, didFailWithError error: NSError) {
        syncMessage = "Failed with Error \(error.localizedDescription)" + separatorLine + separatorLine
        self.notify(syncMessage)
    }

    func swiftCoapClient(client: SCClient, didSendMessage message: SCMessage, number: Int) {
        log("Message Sent")
    }
}
