@testable import ReactiveTODOFramework
import Nimble
import Quick


class DateResolverSpec: QuickSpec {
    override func spec() {
        describe("DateResolver") {
            let sut = DateResolver()
            
            it("Should resolve incremental dates") {
                let firstDate = NSDate(timeIntervalSinceNow: 0)
                usleep(1)
                let secondDate = sut.now()
                usleep(1)
                let thirdDate = sut.now()
                usleep(1)
                let fourhDate = NSDate(timeIntervalSinceNow: 0)
                
                expect(firstDate.timeIntervalSince1970)
                    .to(beLessThan(secondDate.timeIntervalSince1970))
                expect(secondDate.timeIntervalSince1970)
                    .to(beLessThan(thirdDate.timeIntervalSince1970))
                expect(thirdDate.timeIntervalSince1970)
                    .to(beLessThan(fourhDate.timeIntervalSince1970))
            }
        }
    }
}
