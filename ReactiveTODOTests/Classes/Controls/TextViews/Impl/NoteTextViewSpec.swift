@testable import ReactiveTODOFramework
import Foundation
import Nimble
import Quick


class NoteTextViewSpec: QuickSpec {

    override func spec() {
        describe("NoteTextView") {
            let validator = NoteValidatorMock()
            let sut = NoteTextView(validator: Validator(validator))

            it("Should bind nil instead of invalid note value") {
                sut.note.value = "Not nil value"
                validator.isValid = false

                self.fireTextViewChangeEvent(sut, text: "Some text")

                expect(sut.note.value).toEventually(beNil())
            }

            it("Should bind valid note value") {
                sut.note.value = nil
                validator.isValid = true

                self.fireTextViewChangeEvent(sut, text: "Some text")

                expect(sut.note.value).toEventually(equal("Some text"))
            }

            it("Should have valid value border color for valid note") {
                sut.note.value = "Valid value"

                expect(sut.layer.borderColor)
                    .toEventually(equal(UIColor.validValueColor().CGColor))
            }

            it("Should have invalid value border color for invalid note") {
                sut.note.value = nil

                expect(sut.layer.borderColor)
                    .toEventually(equal(UIColor.invalidValueColor().CGColor))
            }
        }
    }

    private func fireTextViewChangeEvent(textView: UITextView, text: String?) {
        dispatch_async(dispatch_get_main_queue()) {
            textView.text = text

            let notification = NSNotification(
                    name: UITextViewTextDidChangeNotification,
                    object: textView)

            NSNotificationCenter.defaultCenter().postNotification(notification)
        }
    }
}
