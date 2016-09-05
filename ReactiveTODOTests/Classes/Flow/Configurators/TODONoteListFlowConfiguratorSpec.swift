@testable import ReactiveTODO
import Nimble
import Quick


class TODONoteListFlowConfiguratorSpec: QuickSpec {

    override func spec() {
        describe("TODONoteListFlowConfigurator") {
            let sut = TODONoteListFlowConfigurator()

            it("Should return false if controller is not a TODO list") {
                let controller = ViewControllerMock(nibName: nil, bundle: nil)

                let configureResult = sut.configureFlow(controller)

                expect(configureResult).to(beFalse())
            }

            it("Should return true if controller is a TODO list") {
                let controller = TODONoteListViewInteractionMock()

                let configureResult = sut.configureFlow(controller)

                expect(configureResult).to(beTrue())
            }
        }
    }
}
