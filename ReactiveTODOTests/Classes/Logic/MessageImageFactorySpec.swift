@testable import ReactiveTODOFramework
import Foundation
import Messages
import Nimble
import Quick


@available(iOS 10.0, *)
class MessageImageFactorySpec: QuickSpec {
    
    override func spec() {
        describe("MessageImageFactory") {
            let bundle = NSBundle(forClass: MessageImageFactorySpec.self)
            let priorityFormatter = PriorityImageNameFormatterMock()
            priorityFormatter.formatReturnValue = "white_pixel"
            let sut = MessageImageFactory(bundle: bundle, priorityFormatter: priorityFormatter)
        }
    }
}
