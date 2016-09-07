import Foundation


class DateValidator: ValidatorProtocol {

    let dateResolver: DateResolverProtocol

    init(dateResolver: DateResolverProtocol) {
        self.dateResolver = dateResolver
    }

    func validate(data: NSDate?) -> Bool {
        guard let date = data else {
            return false
        }

        let now = self.dateResolver.now()
        return date.timeIntervalSince1970 > now.timeIntervalSince1970
    }
}
