@testable import ReactiveTODO
import Nimble
import Quick


class PriorityImageNameFormatterSpec: QuickSpec {
    override func spec() {
        describe("PriorityImageNameFormatter") {
            let sut = PriorityImageNameFormatter()

            it("Should resolve low priority image name") {
                let image = sut.format(.Low)

                expect(image).to(equal("priority_low"))
            }

            it("Should resolve medium priority image name") {
                let image = sut.format(.Medium)

                expect(image).to(equal("priority_medium"))
            }

            it("Should resolve high priority image name") {
                let image = sut.format(.High)

                expect(image).to(equal("priority_high"))
            }

            it("Should resolve urgent priority image name") {
                let image = sut.format(.Urgent)

                expect(image).to(equal("priority_urgent"))
            }
        }
    }
}
