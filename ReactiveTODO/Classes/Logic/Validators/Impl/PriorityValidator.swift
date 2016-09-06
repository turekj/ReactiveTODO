import Foundation


class PriorityValidator: ValidatorProtocol {

    func validate(data: Priority?) -> Bool {
        guard data != nil else {
            return false
        }

        return true
    }
}
