@testable import ReactiveTODOFramework
import Nimble
import Quick


class PriorityValidatorSpec: QuickSpec {

    override func spec() {
        describe("PriorityValidator") {
            let sut = PriorityValidator()

            it("Should return false for nil priority") {
                expect(sut.validate(nil)).to(beFalse())
            }

            it("Should return true for any priority") {
                expect(sut.validate(Priority.Urgent)).to(beTrue())
                expect(sut.validate(Priority.High)).to(beTrue())
                expect(sut.validate(Priority.Medium)).to(beTrue())
                expect(sut.validate(Priority.Low)).to(beTrue())
            }
        }
    }
}
