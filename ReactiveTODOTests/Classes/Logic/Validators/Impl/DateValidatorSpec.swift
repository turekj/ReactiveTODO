@testable import ReactiveTODO
import Nimble
import Quick
import RealmSwift


class DateValidatorSpec: QuickSpec {

    override func spec() {
        describe("DateValidator") {
            let dateResolver = DateResolverMock()
            dateResolver.nowReturnValue = NSDate(timeIntervalSince1970: 567)
            let sut = DateValidator(dateResolver: dateResolver)

            it("Should return false for nil date") {
                expect(sut.validate(nil)).to(beFalse())
            }

            it("Should return false for past value") {
                expect(sut.validate(NSDate(timeIntervalSince1970: 456)))
                .to(beFalse())
            }

            it("Should return false for now value") {
                expect(sut.validate(NSDate(timeIntervalSince1970: 567)))
                .to(beFalse())
            }

            it("Should return true for future value") {
                expect(sut.validate(NSDate(timeIntervalSince1970: 678)))
                .to(beTrue())
            }
        }
    }
}
