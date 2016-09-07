@testable import ReactiveTODO
import Nimble
import Quick


class PriorityPickerSpec: QuickSpec {
    override func spec() {
        describe("PriorityPicker") {
            let validator = PriorityValidatorMock()
            let priorities = [Priority.Urgent, Priority.Low]
            let sut = PriorityPicker(validator: Validator(validator),
                    priorities: priorities)

            it("Should map priorities to raw values") {
                expect(sut.numberOfSegments).to(equal(2))
                expect(sut.titleForSegmentAtIndex(0)).to(equal("Urgent"))
                expect(sut.titleForSegmentAtIndex(1)).to(equal("Low"))
            }
        }
    }
}
