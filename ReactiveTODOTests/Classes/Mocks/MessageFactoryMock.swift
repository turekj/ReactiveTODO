@testable import ReactiveTODOFramework
import Foundation
import Messages


@available(iOS 10.0, *)
class MessageFactoryMock: MessageFactoryProtocol {
    
    var createdMessageGuid: String?
    var returnedMessage = MSMessage()
    
    func createMessage(noteGUID: String) -> MSMessage {
        self.createdMessageGuid = noteGUID
        return self.returnedMessage
    }
}
