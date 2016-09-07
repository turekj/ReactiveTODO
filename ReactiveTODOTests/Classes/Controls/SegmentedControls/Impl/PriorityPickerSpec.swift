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

            it("Should bind invalid priorities to nil") {
                sut.priority.value = .Low
                validator.isValid = false

                self.firePriorityPickerChange(sut, selectedIndex: 0)

                expect(sut.priority.value).toEventually(beNil())
            }

            it("Should bind valid priorities to values") {
                sut.priority.value = nil
                validator.isValid = true

                self.firePriorityPickerChange(sut, selectedIndex: 0)

                expect(sut.priority.value).toEventually(equal(Priority.Urgent))
            }

            it("Should have valid value border color for valid priority") {
                sut.priority.value = Priority.High

                expect(sut.layer.borderColor)
                    .toEventually(equal(UIColor.validValueColor().CGColor))
            }

            it("Should have invalid value border color for invalid priority") {
                sut.priority.value = nil

                expect(sut.layer.borderColor)
                    .toEventually(equal(UIColor.invalidValueColor().CGColor))
            }

            it("Should have valid value tint color for valid priority") {
                sut.priority.value = Priority.High

                expect(sut.tintColor)
                    .toEventually(equal(UIColor.validValueColor()))
            }

            it("Should have invalid value tint color for invalid priority") {
                sut.priority.value = nil

                expect(sut.tintColor)
                    .toEventually(equal(UIColor.invalidValueColor()))
            }
        }
    }

    private func firePriorityPickerChange(priorityPicker: PriorityPicker,
                                          selectedIndex: Int) {
        dispatch_async(dispatch_get_main_queue()) {
            priorityPicker.selectedSegmentIndex = selectedIndex
            priorityPicker.sendActionsForControlEvents(.ValueChanged)
        }
    }
}
