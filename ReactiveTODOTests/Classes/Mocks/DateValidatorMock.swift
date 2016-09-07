@testable import ReactiveTODO
import Foundation


class DateValidatorMock: ValidatorProtocol {

    var isValid = false

    func validate(data: NSDate?) -> Bool {
        return self.isValid
    }
}
