@testable import ReactiveTODOFramework
import Nimble
import Quick


class GUIDGeneratorSpec: QuickSpec {
    override func spec() {
        describe("GUIDGenerator") {
            let sut = GUIDGenerator()
            
            it("Should generate 32 hex character identifier") {
                let guid = sut.generateGUID()
                
                expect(guid).to(match("[0-9a-f]{32}"))
            }
            
            it("Should generate unique identifiers") {
                let firstGuid = sut.generateGUID()
                let secondGuid = sut.generateGUID()
                
                expect(firstGuid).toNot(equal(secondGuid))
            }
        }
    }
}
