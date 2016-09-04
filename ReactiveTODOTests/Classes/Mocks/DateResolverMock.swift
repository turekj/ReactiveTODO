@testable import ReactiveTODO
import Foundation


class DateResolverMock: DateResolverProtocol {
    
    var nowReturnValue = NSDate(timeIntervalSince1970: 123)
    
    func now() -> NSDate {
        return self.nowReturnValue
    }
}
