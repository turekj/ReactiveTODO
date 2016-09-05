import Foundation


class PriorityImageNameFormatter: PriorityImageNameFormatterProtocol {

    func format(priority: Priority) -> String {
        let suffix = priority.rawValue.lowercaseString
        return "priority_\(suffix)"
    }
}
