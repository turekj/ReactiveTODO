import UIKit


@available(iOSApplicationExtension 10.0, *)
public protocol MessageFlowControllerProtocol {
    
    func startFlow(messageController: MessagesViewControllerProtocol)
}
