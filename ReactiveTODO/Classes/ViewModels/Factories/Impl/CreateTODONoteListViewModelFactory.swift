import Foundation


class CreateTODONoteListViewModelFactory:
        CreateTODONoteListViewModelFactoryProtocol {

    func createViewModel() -> CreateTODONoteViewModel {
        return CreateTODONoteViewModel(
                date: nil,
                note: nil,
                priority: nil)
    }
}
