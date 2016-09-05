import Foundation


protocol PriorityImageNameFormatterProtocol {

    func format(priority: Priority) -> String
}


class PriorityImageNameFormatter: PriorityImageNameFormatterProtocol {

    func format(priority: Priority) -> String {
        let suffix = priority.rawValue.lowercaseString
        return "priority_\(suffix)"
    }
}
