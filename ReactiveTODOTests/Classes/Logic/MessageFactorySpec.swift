@testable import ReactiveTODOFramework
import Foundation
import Messages
import Nimble
import Quick


@available(iOS 10.0, *)
class MessageFactorySpec: QuickSpec {
    
    override func spec() {
        describe("MessageFactory") {
            let bundle = NSBundle(forClass: MessageFactorySpec.self)
            let todoNoteDAO = TODONoteDataAccessObjectMock()
            let note = TODONote()
            note.priority = .High
            note.note = "Something to do"
            todoNoteDAO.resolvedNote = note
            
            let dateFormatter = DateFormatterMock()
            let priorityFormatter = PriorityImageNameFormatterMock()
            priorityFormatter.formatReturnValue = "white_pixel"
            let sut = MessageFactory(bundle: bundle, todoNoteDAO: todoNoteDAO,
                                     dateFormatter: dateFormatter,
                                     priorityFormatter: priorityFormatter)
            
            it("Should resolve correct note") {
                sut.createMessage("correct_note_guid")
                
                expect(todoNoteDAO.resolvedNoteGuid).to(equal("correct_note_guid"))
            }
            
            it("Should create message layout") {
                let message = sut.createMessage("selfie_guid")
                
                expect(message.layout).toNot(beNil())
                expect(message.layout).to(beAKindOf(MSMessageTemplateLayout.self))
            }
            
            it("Should set message image") {
                let expectedImage = UIImage(named: "white_pixel",
                                            inBundle: bundle,
                                            compatibleWithTraitCollection: nil)!
                let expectedImageData = UIImagePNGRepresentation(expectedImage)
                
                let message = sut.createMessage("asdf")
                
                expect((message.layout as? MSMessageTemplateLayout)?.image).toNot(beNil())
                expect(UIImagePNGRepresentation(
                    ((message.layout as? MSMessageTemplateLayout)?.image)!)).to(
                        equal(expectedImageData))
            }
            
            it("Should set message title") {
                let message = sut.createMessage("123")
                
                expect((message.layout as? MSMessageTemplateLayout)?.imageTitle).to(
                        equal("Something to do"))
            }
        }
    }
}
