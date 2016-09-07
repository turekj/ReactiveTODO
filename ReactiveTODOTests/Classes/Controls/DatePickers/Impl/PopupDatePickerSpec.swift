@testable import ReactiveTODO
import Nimble
import Quick
import RealmSwift
import UIKit


class PopupDatePickerSpec: QuickSpec {

    override func spec() {
        describe("PopupDatePicker") {
            let validator = DateValidatorMock()
            let dateFormatter = DateFormatterMock()
            let datePicker = UIDatePicker()
            let triggerPickerButton = UIButton(type: .RoundedRect)
            let sut = PopupDatePicker(validator: Validator(validator),
                    dateFormatter: dateFormatter,
                    datePicker: datePicker,
                    triggerPickerButton: triggerPickerButton)

            context("When clicking trigger picker button") {
                it("Should toggle date picker visibility") {
                    datePicker.hidden = true

                    self.fireButtonClickEvent(triggerPickerButton)

                    expect(datePicker.hidden).toEventually(beFalse())

                    self.fireButtonClickEvent(triggerPickerButton)

                    expect(datePicker.hidden).toEventually(beTrue())
                }
            }

            context("When date is changed on a date picker") {
                it("Should bind invalid date to nil") {
                    sut.date.value = NSDate()
                    validator.isValid = false

                    self.fireDateChangeEvent(datePicker, date: NSDate())

                    expect(sut.date.value).toEventually(beNil())
                }

                it("Should bind valid date to value") {
                    sut.date.value = nil
                    validator.isValid = true

                    self.fireDateChangeEvent(datePicker,
                            date: NSDate(timeIntervalSince1970: 1234))

                    expect(sut.date.value).toEventually(
                            equal(NSDate(timeIntervalSince1970: 1234)))
                }
            }

            context("When date property is nil") {
                it("Should set button's title to select date") {
                    sut.date.value = nil

                    expect(triggerPickerButton.titleForState(.Normal))
                        .toEventually(equal("Select future date"))
                }

                it("Should set button's title color to invalid value color") {
                    sut.date.value = nil

                    expect(triggerPickerButton.titleColorForState(.Normal))
                        .toEventually(equal(UIColor.invalidValueColor()))
                }

                it("Should set button's border color to invalid value color") {
                    sut.date.value = nil

                    expect(triggerPickerButton.layer.borderColor)
                        .toEventually(equal(
                            UIColor.invalidValueColor().CGColor))
                }
            }

            context("When date property is not nil") {
                it("Should set button's title to formatted date") {
                    dateFormatter.formatReturnValue = "formatted date"
                    sut.date.value = NSDate(timeIntervalSinceNow: 9)

                    expect(triggerPickerButton.titleForState(.Normal))
                        .toEventually(equal("formatted date"))
                }

                it("Should set button's title color to valid value color") {
                    sut.date.value = NSDate(timeIntervalSinceNow: 1)

                    expect(triggerPickerButton.titleColorForState(.Normal))
                        .toEventually(equal(UIColor.validValueColor()))
                }

                it("Should set button's border color to valid value color") {
                    sut.date.value = NSDate(timeIntervalSinceNow: 666)

                    expect(triggerPickerButton.layer.borderColor)
                        .toEventually(equal(UIColor.validValueColor().CGColor))
                }
            }
        }
    }

    private func fireButtonClickEvent(button: UIButton) {
        dispatch_async(dispatch_get_main_queue()) {
            button.sendActionsForControlEvents(.TouchDown)
            button.sendActionsForControlEvents(.TouchUpInside)
        }
    }

    private func fireDateChangeEvent(datePicker: UIDatePicker, date: NSDate) {
        dispatch_async(dispatch_get_main_queue()) {
            datePicker.date = date
            datePicker.sendActionsForControlEvents(.ValueChanged)
        }
    }
}
