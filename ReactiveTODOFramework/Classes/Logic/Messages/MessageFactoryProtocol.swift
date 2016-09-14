import Foundation
import Messages


@available(iOSApplicationExtension 10.0, *)
public protocol MessageFactoryProtocol {
    
    func createMessage(noteGUID: String) -> MSMessage
}
