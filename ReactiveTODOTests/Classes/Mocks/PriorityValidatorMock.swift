@testable import ReactiveTODOFramework
import Foundation


class PriorityValidatorMock: ValidatorProtocol {

    var isValid = false

    func validate(data: Priority?) -> Bool {
        return self.isValid
    }
}
