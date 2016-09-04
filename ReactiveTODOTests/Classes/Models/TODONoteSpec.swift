@testable import ReactiveTODO
import Foundation
import Nimble
import Quick


class TODONoteSpec: QuickSpec {
    override func spec() {
        describe("TODONote") {
            it("Should have guid property") {
                let sut = TODONote()
                
                expect(sut.guid).to(equal(""))
            }
            
            it("Should have note property") {
                let sut = TODONote()
                
                expect(sut.note).to(equal(""))
            }
            
            it("Should have date property") {
                let sut = TODONote()
                
                expect(sut.date).to(equal(NSDate(timeIntervalSince1970: 1)))
            }
            
            it("Should have primary key set") {
                let primaryKey = TODONote.primaryKey()
                
                expect(primaryKey).toNot(beNil())
                expect(primaryKey).to(equal("guid"))
            }
        }
    }
}
