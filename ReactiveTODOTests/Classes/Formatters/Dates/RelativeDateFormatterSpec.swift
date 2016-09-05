@testable import ReactiveTODO
import Nimble
import Quick


class RelativeDateFormatterSpec: QuickSpec {

    override func spec() {
        describe("RelativeDateFormatter") {
            let sut = RelativeDateFormatter()

            it("Should format today properly") {
                let todayNoon = self.noon(NSDate())

                let formatted = sut.format(todayNoon)

                expect(formatted).to(equal("Today, 12:00 PM"))
            }

            it("Should format yesterday properly") {
                let yesterday = NSDate(timeIntervalSinceNow: -24 * 3600)
                let yesterdayNoon = self.noon(yesterday)

                let formatted = sut.format(yesterdayNoon)

                expect(formatted).to(equal("Yesterday, 12:00 PM"))
            }
        }
    }

    func noon(date: NSDate) -> NSDate {
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(
                [.Era, .Year, .Month, .Day],
                fromDate: date)
        components.hour = 12
        components.minute = 00
        components.second = 00

        return calendar.dateFromComponents(components)!
    }
}
