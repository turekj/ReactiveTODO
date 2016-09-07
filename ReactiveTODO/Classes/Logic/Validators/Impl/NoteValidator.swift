import Foundation


class NoteValidator: ValidatorProtocol {

    func validate(data: String?) -> Bool {
        guard let note = data else {
            return false
        }

        return note.characters.count > 2
    }
}
