import Foundation


protocol RelativeDateFormatterProtocol {

    func format(date: NSDate) -> String
}


class RelativeDateFormatter: RelativeDateFormatterProtocol {

    func format(date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .ShortStyle
        formatter.doesRelativeDateFormatting = true

        return formatter.stringFromDate(date)
    }
}
