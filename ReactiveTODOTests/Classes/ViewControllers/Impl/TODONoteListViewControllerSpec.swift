@testable import ReactiveTODO
import Nimble
import Quick
import RealmSwift


class TODONoteListViewControllerSpec: QuickSpec {

    override func spec() {
        describe("TODONoteListViewController") {
            var sut: TODONoteListViewController!
            var viewModel: TODONoteListViewModel!
            var view: TODONoteListView!
            let bundle = NSBundle(
                    forClass: TODONoteListViewControllerSpec.self)
            let dateFormatter = DateFormatterMock()
            let priorityFormatter = PriorityImageNameFormatterMock()
            let cellFactory = TODONoteListCellFactory(bundle: bundle,
                    dateFormatter: dateFormatter,
                    priorityFormatter: priorityFormatter)

            beforeEach {
                let note = TODONote()
                note.guid = "selected_todo"
                note.note = "Some note"
                note.date = NSDate(timeIntervalSince1970: 111)
                note.completed = false
                note.priority = .Urgent

                let realm = try! Realm()

                try! realm.write {
                    realm.add(note)
                }

                let notes = realm.objects(TODONote.self)
                viewModel = TODONoteListViewModel(notes: notes)
                view = TODONoteListView()
                sut = TODONoteListViewController(view: view,
                        viewModel: viewModel,
                        cellFactory: cellFactory)
                sut.viewDidLoad()
            }

            afterEach {
                viewModel.notes.notificationToken?.stop()
            }

            it("Should invoke callback on add button tap") {
                var addButtonTapped = false
                sut.onAddTODO = { addButtonTapped = true }

                self.fireButtonTapEvent(view.addButton)

                expect(addButtonTapped).toEventually(beTrue())
            }

            it("Should invoke callback on select TODO note") {
                var selectedTODO: String?
                sut.onSelectTODO = { selectedTODO = $0 }

                self.fireRowSelectionEvent(view.list,
                        indexPath: NSIndexPath(forRow: 0, inSection: 0))

                expect(selectedTODO).toEventually(equal("selected_todo"))
            }
        }
    }

    private func fireButtonTapEvent(button: UIButton) {
        dispatch_async(dispatch_get_main_queue()) {
            button.sendActionsForControlEvents(.TouchDown)
            button.sendActionsForControlEvents(.TouchUpInside)
        }
    }

    private func fireRowSelectionEvent(tableView: UITableView,
                                       indexPath: NSIndexPath) {
        dispatch_async(dispatch_get_main_queue()) {
            tableView.selectRowAtIndexPath(indexPath, animated: false,
                    scrollPosition: .None)
            tableView.delegate?.tableView?(tableView,
                    didSelectRowAtIndexPath: indexPath)
        }
    }
}
