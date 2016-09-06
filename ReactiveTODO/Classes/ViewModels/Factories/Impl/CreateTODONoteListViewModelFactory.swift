import Foundation


class CreateTODONoteListViewModelFactory:
        CreateTODONoteListViewModelFactoryProtocol {

    let dateResolver: DateResolverProtocol

    init(dateResolver: DateResolverProtocol) {
        self.dateResolver = dateResolver
    }

    func createViewModel() -> CreateTODONoteViewModel {
        return CreateTODONoteViewModel(
                date: dateResolver.now(),
                note: nil,
                priority: nil)
    }
}
