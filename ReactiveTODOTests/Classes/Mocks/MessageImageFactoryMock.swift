@testable import ReactiveTODOFramework
import Foundation


class MessageImageFactoryMock: MessageImageFactoryProtocol {
    
    var returnedImage: UIImage?
    
    func createMessageImage(note: TODONote) -> UIImage {
        return self.returnedImage!
    }
}
