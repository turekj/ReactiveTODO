import Foundation
import RealmSwift


class TODONoteListViewModelFactory: TODONoteListViewModelFactoryProtocol {

    func createViewModel() -> TODONoteListViewModel {
        let realm = try! Realm()
        let notes = realm.objects(TODONote.self)

        return TODONoteListViewModel(notes: notes)
    }
}
