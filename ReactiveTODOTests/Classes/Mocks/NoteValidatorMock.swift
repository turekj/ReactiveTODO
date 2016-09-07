@testable import ReactiveTODO
import Foundation


class NoteValidatorMock: ValidatorProtocol {

    var isValid = false

    func validate(data: String?) -> Bool {
        return self.isValid
    }
}
