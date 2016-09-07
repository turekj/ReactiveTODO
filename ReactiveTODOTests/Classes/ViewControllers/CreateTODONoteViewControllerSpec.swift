@testable import ReactiveTODO
import Nimble
import Quick
import RealmSwift


class CreateTODONoteViewControllerSpec: QuickSpec {

    override func spec() {
        describe("CreateTODONoteViewController") {
            let dateFormatter = DateFormatterMock()
            let dateValidator = Validator(DateValidatorMock())
            let noteValidator = Validator(NoteValidatorMock())
            let priorityValidator = Validator(PriorityValidatorMock())
            let noteTextView = NoteTextViewFirstResponderMock(
                    validator: Validator(noteValidator))
            let priorityPicker = PriorityPicker(
                    validator: Validator(priorityValidator),
                    priorities: [Priority.Urgent])
            let datePicker = PopupDatePicker(validator: dateValidator,
                    dateFormatter: dateFormatter,
                    datePicker: UIDatePicker(),
                    triggerPickerButton: UIButton(type: .RoundedRect))
            let view = CreateTODONoteView(noteLabel: UILabel(),
                    noteTextView: noteTextView,
                    priorityLabel: UILabel(),
                    priorityPicker: priorityPicker,
                    dateLabel: UILabel(),
                    datePicker: datePicker)
            let viewModel = CreateTODONoteViewModel(formValid: false)

            let sut = CreateTODONoteViewController(view: view,
                    viewModel: viewModel,
                    dateValidator: dateValidator,
                    noteValidator: noteValidator,
                    priorityValidator: priorityValidator)
            sut.viewDidLoad()

            it("Should have right bar button item attached") {
                expect(sut.navigationItem.rightBarButtonItem).toNot(beNil())
            }

            it("Should block save button if there is no valid date") {
                sut.navigationItem.rightBarButtonItem!.enabled = true
                noteTextView.note.value = "Value"
                priorityPicker.priority.value = Priority.High
                datePicker.date.value = nil

                expect(sut.navigationItem.rightBarButtonItem!.enabled)
                    .toEventually(beFalse())
            }

            it("Should block save button if there is no valid note") {
                sut.navigationItem.rightBarButtonItem!.enabled = true
                noteTextView.note.value = nil
                priorityPicker.priority.value = Priority.High
                datePicker.date.value = NSDate(timeIntervalSince1970: 123)

                expect(sut.navigationItem.rightBarButtonItem!.enabled)
                    .toEventually(beFalse())
            }

            it("Should block save button if there is no valid priority") {
                sut.navigationItem.rightBarButtonItem!.enabled = true
                noteTextView.note.value = "Value"
                priorityPicker.priority.value = nil
                datePicker.date.value = NSDate(timeIntervalSince1970: 123)

                expect(sut.navigationItem.rightBarButtonItem!.enabled)
                    .toEventually(beFalse())
            }

            it("Should unlock save button if all data is valid") {
                sut.navigationItem.rightBarButtonItem!.enabled = false
                noteTextView.note.value = "Value"
                priorityPicker.priority.value = Priority.Low
                datePicker.date.value = NSDate(timeIntervalSince1970: 123)

                expect(sut.navigationItem.rightBarButtonItem!.enabled)
                    .toEventually(beTrue())
            }

            it("Should make note text view resign first responder on tap") {
                noteTextView.resignedFirstResponder = false

                view.tapStream.next()

                expect(noteTextView.resignedFirstResponder)
                    .toEventually(beTrue())
            }

            it("Should invoke on save action when save button is pressed") {
                noteTextView.note.value = "Saved Note"
                datePicker.date.value = NSDate(timeIntervalSince1970: 9999)
                priorityPicker.priority.value = .Medium

                var savedDate: NSDate?
                var savedNote: String?
                var savedPriority: Priority?

                sut.onSave = { date, note, priority in
                    savedDate = date
                    savedNote = note
                    savedPriority = priority
                }

                self.fireRightNavigationButtonClickEvent(sut)

                expect(savedDate).toEventuallyNot(beNil())
                expect(savedDate).toEventually(
                        equal(NSDate(timeIntervalSince1970: 9999)))
                expect(savedNote).toEventuallyNot(beNil())
                expect(savedNote).toEventually(equal("Saved Note"))
                expect(savedPriority).toEventuallyNot(beNil())
                expect(savedPriority).toEventually(equal(Priority.Medium))
            }
        }
    }

    private func fireRightNavigationButtonClickEvent(
            viewController: UIViewController) {
        dispatch_async(dispatch_get_main_queue()) {
            let barButton = viewController.navigationItem.rightBarButtonItem!

            barButton.target?.performSelector(barButton.action)
        }
    }
}
