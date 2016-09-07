import Foundation
import ReactiveKit


class CreateTODONoteViewModel {

    let formValid: Property<Bool>

    init(formValid: Bool) {
        self.formValid = Property(formValid)
    }
}
