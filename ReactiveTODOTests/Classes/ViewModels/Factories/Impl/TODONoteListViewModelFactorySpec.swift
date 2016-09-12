@testable import ReactiveTODO
import Nimble
import Quick
import RealmSwift


class TODONoteListViewModelFactorySpec: QuickSpec {

    override func spec() {
        describe("TODONoteListViewModelFactory") {
            let dao = TODONoteDataAccessObjectMock()
            let sut = TODONoteListViewModelFactory(todoNoteDAO: dao)

            beforeEach {
                let realm = try! Realm()

                let firstTodo = TODONote()
                firstTodo.guid = "1st"

                let secondTodo = TODONote()
                secondTodo.guid = "2nd"

                try! realm.write {
                    realm.add(firstTodo)
                    realm.add(secondTodo)
                }
            }

            context("When creating a view model") {

                it("Should fetch all current notes from dao") {
                    dao.targetGuid = "1st"
                    let viewModel = sut.createViewModel()
                    let notes = viewModel.notes.collection

                    expect(notes.count).to(equal(1))
                    expect(notes[0].guid).to(equal("1st"))
                }
            }
        }
    }
}
