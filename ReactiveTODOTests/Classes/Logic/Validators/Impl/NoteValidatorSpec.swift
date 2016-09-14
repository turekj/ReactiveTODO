@testable import ReactiveTODO
import Nimble
import Quick


class NoteValidatorSpec: QuickSpec {

    override func spec() {
        describe("NoteValidator") {
            let sut = NoteValidator()

            it("Should return false for nil note") {
                expect(sut.validate(nil)).to(beFalse())
            }

            it("Should return false for empty note") {
                expect(sut.validate("")).to(beFalse())
            }

            it("Should return false for short note") {
                expect(sut.validate("a")).to(beFalse())
                expect(sut.validate("ab")).to(beFalse())
            }

            it("Should return true for at least 3-character note") {
                expect(sut.validate("abc")).to(beTrue())
            }
        }
    }
}
