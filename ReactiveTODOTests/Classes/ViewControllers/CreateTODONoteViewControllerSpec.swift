@testable import ReactiveTODO
import Nimble
import Quick
import RealmSwift


class CreateTODONoteViewControllerSpec: QuickSpec {

    override func spec() {
        describe("CreateTODONoteViewController") {
            let view = CreateTODONoteView()
            let viewModel = CreateTODONoteViewModel(date: NSDate(),
                    note: nil, priority: nil)
            let sut = CreateTODONoteViewController(view: view,
                    viewModel: viewModel)
            sut.viewDidLoad()

            it("Should bind datepicker value to view model") {
                dispatch_async(dispatch_get_main_queue()) {
                    view.datePicker.date = NSDate(timeIntervalSince1970: 999)
                    view.datePicker.sendActionsForControlEvents(.ValueChanged)
                }

                expect(viewModel.date.value)
                    .toEventually(equal(NSDate(timeIntervalSince1970: 999)))
            }

            it("Should bind note field value to view model") {
                dispatch_async(dispatch_get_main_queue()) {
                    view.noteTextView.text = "Example"
                    let notification = NSNotification(
                            name: UITextViewTextDidChangeNotification,
                            object: view.noteTextView)
                    NSNotificationCenter.defaultCenter()
                        .postNotification(notification)
                }

                expect(viewModel.note.value).toEventually(equal("Example"))
             }

            it("Should bind priority value to view model") {
                dispatch_async(dispatch_get_main_queue()) {
                    view.priorityPicker.selectedSegmentIndex = 3
                    view.priorityPicker.sendActionsForControlEvents(
                            .ValueChanged)
                }

                expect(viewModel.priority.value?.rawValue)
                    .toEventually(equal(Priority.Low.rawValue))
            }

            it("Should have right bar button item attached") {
                expect(sut.navigationItem.rightBarButtonItem).toNot(beNil())
            }

            it("Should invoke on save action when save button is pressed") {
                var onSaveTriggered = false

                sut.onSave = {
                    onSaveTriggered = true
                }

                dispatch_async(dispatch_get_main_queue()) {
                    let barButton = sut.navigationItem.rightBarButtonItem!

                    barButton.target?.performSelector(barButton.action)
                }

                expect(onSaveTriggered).toEventually(beTrue())
            }
        }
    }
}
