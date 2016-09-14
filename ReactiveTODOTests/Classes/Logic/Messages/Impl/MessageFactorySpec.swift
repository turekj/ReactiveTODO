@testable import ReactiveTODOFramework
import Foundation
import Messages
import Nimble
import Quick


@available(iOS 10.0, *)
class MessageFactorySpec: QuickSpec {
    
    override func spec() {
        describe("MessageFactory") {
            let todoNoteDAO = TODONoteDataAccessObjectMock()
            let note = TODONote()
            note.priority = .High
            note.note = "Something to do"
            todoNoteDAO.resolvedNote = note
            
            let dateFormatter = DateFormatterMock()
            dateFormatter.formatReturnValue = "formatted_D@73"
            
            let bundle = NSBundle(forClass: MessageFactorySpec.self)
            let imageFactory = MessageImageFactoryMock()
            imageFactory.returnedImage = UIImage(named: "white_pixel",
                                                 inBundle: bundle,
                                                 compatibleWithTraitCollection: nil)
            
            let sut = MessageFactory(todoNoteDAO: todoNoteDAO,
                                     dateFormatter: dateFormatter,
                                     messageImageFactory: imageFactory)
            
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
            
            it("Should set title with note") {
                let message = sut.createMessage("123")
                
                expect((message.layout as? MSMessageTemplateLayout)?.caption).to(
                        equal("Something to do"))
            }
            
            it("Should set subtitle with date") {
                let message = sut.createMessage("890")
                
                expect((message.layout as? MSMessageTemplateLayout)?.subcaption).to(
                    equal("formatted_D@73"))
            }
        }
    }
}
