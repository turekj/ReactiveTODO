@testable import ReactiveTODOFramework
import Foundation


class DateFormatterMock: DateFormatterProtocol {

    var formatReturnValue = ""

    func format(date: NSDate) -> String {
        return self.formatReturnValue
    }
}
