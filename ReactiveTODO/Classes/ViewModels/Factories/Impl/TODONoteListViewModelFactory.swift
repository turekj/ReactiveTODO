import Foundation
import RealmSwift


class TODONoteListViewModelFactory: TODONoteListViewModelFactoryProtocol {

    let todoNoteDAO: TODONoteDataAccessObjectProtocol

    init(todoNoteDAO: TODONoteDataAccessObjectProtocol) {
        self.todoNoteDAO = todoNoteDAO
    }

    func createViewModel() -> TODONoteListViewModel {
        return TODONoteListViewModel(
                notes: self.todoNoteDAO.getCurrentTODONotes())
    }
}
