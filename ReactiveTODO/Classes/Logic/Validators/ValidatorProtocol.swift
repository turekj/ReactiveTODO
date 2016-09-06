import Foundation


protocol ValidatorProtocol {
    associatedtype DataType

    func validate(data: DataType) -> Bool
}
