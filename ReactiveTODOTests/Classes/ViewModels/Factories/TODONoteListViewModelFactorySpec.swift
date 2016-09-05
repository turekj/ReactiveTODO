@testable import ReactiveTODO
import Nimble
import Quick
import RealmSwift


class TODONoteListViewModelFactorySpec: QuickSpec {

    override func spec() {
        describe("TODONoteListViewModelFactory") {
            Realm.Configuration
                .defaultConfiguration
                .inMemoryIdentifier = self.name

            let sut = TODONoteListViewModelFactory()

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

            afterEach {
                let realm = try! Realm()

                try! realm.write {
                    realm.deleteAll()
                }
            }

            context("When creating a view model") {
                
                it("Should fetch all notes") {
                    let viewModel = sut.createViewModel()
                    let notes = viewModel.notes.collection

                    expect(notes.count).to(equal(2))
                    expect(notes[0].guid).to(equal("1st"))
                    expect(notes[1].guid).to(equal("2nd"))
                }
            }
        }
    }
}
