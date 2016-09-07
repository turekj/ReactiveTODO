import Foundation


class CreateTODONoteListViewModelFactory:
        CreateTODONoteListViewModelFactoryProtocol {

    func createViewModel() -> CreateTODONoteViewModel {
        return CreateTODONoteViewModel(formValid: false)
    }
}
