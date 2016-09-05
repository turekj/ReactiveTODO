@testable import ReactiveTODO
import Nimble
import Quick
import RealmSwift


class TODONoteListViewControllerSpec: QuickSpec {

    override func spec() {
        describe("TODONoteListViewController") {
            Realm.Configuration
                .defaultConfiguration
                .inMemoryIdentifier = self.name

            let realm = try! Realm()
            let notes = realm.objects(TODONote.self)
            let viewModel = TODONoteListViewModel(notes: notes)
            let view = TODONoteListView()
            let bundle = NSBundle(
                    forClass: TODONoteListViewControllerSpec.self)
            let dateFormatter = DateFormatterMock()
            let priorityFormatter = PriorityImageNameFormatterMock()
            let cellFactory = TODONoteListCellFactory(bundle: bundle,
                    dateFormatter: dateFormatter,
                    priorityFormatter: priorityFormatter)

            let sut = TODONoteListViewController(view: view,
                    viewModel: viewModel,
                    cellFactory: cellFactory)

            it("Should invoke callback on add button tap") {
                var tapped = false

                sut.onAddTODO = {
                    tapped = true
                }

                view.addButton.sendActionsForControlEvents(.TouchUpInside)

                expect(tapped).toEventually(beTrue())
            }
        }
    }
}
