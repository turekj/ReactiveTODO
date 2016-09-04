@testable import ReactiveTODO
import Nimble
import Quick


class TODONoteFactorySpec: QuickSpec {
    
    override func spec() {
        describe("TODONoteFactory") {
            let dateResolver = DateResolverMock()
            let guidGenerator = GUIDGeneratorMock()
            let sut = TODONoteFactory(dateResolver: dateResolver, guidGenerator: guidGenerator)
            
            context("When creating a new note") {
                let note = sut.createTODONote()
                
                it("Should set date to now") {
                    expect(note.date.timeIntervalSince1970).to(equal(123))
                }
                
                it("Should set unique GUID") {
                    expect(note.guid).to(equal("generated_guid"))
                }
                
                it("Should set low priority") {
                    expect(note.priority).to(equal(Priority.Low))
                }
            }
        }
    }
}
