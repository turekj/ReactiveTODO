import Foundation


protocol ValidatorProtocol {
    associatedtype DataType

    func validate(data: DataType) -> Bool
}


class Validator<T>: ValidatorProtocol {

    private let _validate: (T -> Bool)

    required init<U: ValidatorProtocol where U.DataType == T>(_ validator: U) {
        self._validate = validator.validate
    }

    func validate(data: T) -> Bool {
        return self._validate(data)
    }
}
