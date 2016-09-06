@testable import ReactiveTODO
import Nimble
import Quick


class CreateTODONoteFlowConfiguratorSpec: QuickSpec {

    override func spec() {
        describe("CreateTODONoteFlowConfigurator") {
            let flowController = FlowControllerMock()
            let sut = CreateTODONoteFlowConfigurator()

            it("Should return false if controller is not a TODO creator") {
                let controller = ViewControllerMock(nibName: nil, bundle: nil)

                let configureResult = sut.configureFlow(controller,
                        flowController: flowController)

                expect(configureResult).to(beFalse())
            }

            it("Should return true if controller is a TODO creator") {
                let controller = CreateTODONoteViewInteractionMock()

                let configureResult = sut.configureFlow(controller,
                        flowController: flowController)

                expect(configureResult).to(beTrue())
            }

            it("Should set view controller title") {
                let controller = CreateTODONoteViewInteractionMock()

                sut.configureFlow(controller, flowController: flowController)

                expect(controller.title).to(equal("Add TODO"))
            }
        }
    }
}
