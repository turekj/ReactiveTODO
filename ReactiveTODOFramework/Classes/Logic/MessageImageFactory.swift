import Foundation


class MessageImageFactory: MessageImageFactoryProtocol {
    
    let bundle: NSBundle
    let priorityFormatter: PriorityImageNameFormatterProtocol
    
    init(bundle: NSBundle, priorityFormatter: PriorityImageNameFormatterProtocol) {
        self.bundle = bundle
        self.priorityFormatter = priorityFormatter
    }
    
    func createMessageImage(note: TODONote) -> UIImage {
        return UIImage()
    }
}
