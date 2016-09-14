@testable import ReactiveTODOFramework
import Nimble
import Quick
import ReactiveKit
import UIKit


class CreateTODONoteViewSpec: QuickSpec {

    override func spec() {
        describe("CreateTODONoteViewController") {
            let dateFormatter = DateFormatterMock()
            let dateValidator = Validator(DateValidatorMock())
            let noteValidator = Validator(NoteValidatorMock())
            let priorityValidator = Validator(PriorityValidatorMock())
            let noteTextView = NoteTextView(validator: Validator(noteValidator))
            let priorityPicker = PriorityPicker(
                    validator: Validator(priorityValidator),
                    priorities: [Priority.Urgent])
            let datePicker = PopupDatePicker(validator: dateValidator,
                    dateFormatter: dateFormatter,
                    datePicker: UIDatePicker(),
                    triggerPickerButton: UIButton(type: .RoundedRect))
            let sut = CreateTODONoteView(noteLabel: UILabel(),
                    noteTextView: noteTextView,
                    priorityLabel: UILabel(),
                    priorityPicker: priorityPicker,
                    dateLabel: UILabel(),
                    datePicker: datePicker)

            it("Should have gesture recognizer added") {
                expect(sut.gestureRecognizers).toNot(beNil())
                expect(sut.gestureRecognizers?.first)
                    .to(beAnInstanceOf(UITapGestureRecognizer.self))
            }

            it("Should report taps") {
                var tapped = false

                sut.tapStream.observeNext { _ in
                    tapped = true
                }.disposeIn(self.rBag)

                self.triggerTapEvent(sut)

                expect(tapped).toEventually(beTrue())
            }
        }
    }

    private func triggerTapEvent(view: CreateTODONoteView) {
        dispatch_async(dispatch_get_main_queue()) {
            /*  Most probably should implement it better, but the
                UIGestureRecognizer API does not make it easy... */
            view.onTap(nil)
        }
    }
}
