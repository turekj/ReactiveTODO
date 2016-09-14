@testable import ReactiveTODOFramework
import Foundation
import Messages


@available(iOS 10.0, *)
class MSConversationMock: MSConversation {
    
    var insertedMessage: MSMessage?
    
    override func insertMessage(message: MSMessage, completionHandler: ((NSError?) -> Void)?) {
        self.insertedMessage = message
    }
}
