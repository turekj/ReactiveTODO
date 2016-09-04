import Foundation


protocol DateResolverProtocol {
    func now() -> NSDate
}


class DateResolver: DateResolverProtocol {
    func now() -> NSDate {
        return NSDate()
    }
}
