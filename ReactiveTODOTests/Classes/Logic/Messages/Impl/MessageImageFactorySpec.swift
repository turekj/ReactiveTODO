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
            let sut = MessageImageFactory(bundle: bundle,
                                          priorityFormatter: priorityFormatter,
                                          outputImageSize: CGSizeMake(640, 480))
            
            it("Should create an image of a given size") {
                let note = TODONote()
                note.priority = .High
                
                let image = sut.createMessageImage(note)
                
                expect(image.size.width).to(equal(640))
                expect(image.size.height).to(equal(480))
            }
        }
    }
}
