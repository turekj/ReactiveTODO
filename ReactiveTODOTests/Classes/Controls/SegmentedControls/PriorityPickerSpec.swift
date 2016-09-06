@testable import ReactiveTODO
import Nimble
import Quick


class PriorityPickerSpec: QuickSpec {
    override func spec() {
        describe("PriorityPicker") {
            let sut = PriorityPicker()

            it("Should set all priorities by default") {
                expect(sut.numberOfSegments).to(equal(4))
                expect(sut.titleForSegmentAtIndex(0)).to(equal("Urgent"))
                expect(sut.titleForSegmentAtIndex(1)).to(equal("High"))
                expect(sut.titleForSegmentAtIndex(2)).to(equal("Medium"))
                expect(sut.titleForSegmentAtIndex(3)).to(equal("Low"))
            }
        }
    }
}
