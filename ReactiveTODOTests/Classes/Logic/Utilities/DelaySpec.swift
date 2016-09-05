@testable import ReactiveTODO
import Nimble
import Quick


class DelaySpec: QuickSpec {
    override func spec() {
        describe("delay()") {
            it("Should delay operations by fractions of a second") {
                let beforeDelay = NSDate()
                var difference = 0.0

                delay(0.5) {
                    let afterDelay = NSDate()
                    difference = afterDelay.timeIntervalSince1970 -
                            beforeDelay.timeIntervalSince1970
                }

                expect(difference).toEventually(beGreaterThanOrEqualTo(0.5))
            }
        }
    }
}
