@testable import ReactiveTODOFramework
import Foundation


class PriorityImageNameFormatterMock: PriorityImageNameFormatterProtocol {

    var formatReturnValue = ""

    func format(priority: Priority) -> String {
        return self.formatReturnValue
    }
}
