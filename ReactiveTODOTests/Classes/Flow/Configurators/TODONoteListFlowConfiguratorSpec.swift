@testable import ReactiveTODO
import Nimble
import Quick


class TODONoteListFlowConfiguratorSpec: QuickSpec {

    override func spec() {
        describe("TODONoteListFlowConfigurator") {
            let flowController = FlowControllerMock()
            let sut = TODONoteListFlowConfigurator()

            it("Should return false if controller is not a TODO list") {
                let controller = ViewControllerMock(nibName: nil, bundle: nil)

                let configureResult = sut.configureFlow(controller,
                        flowController: flowController)

                expect(configureResult).to(beFalse())
            }

            it("Should return true if controller is a TODO list") {
                let controller = TODONoteListViewInteractionMock()

                let configureResult = sut.configureFlow(controller,
                        flowController: flowController)

                expect(configureResult).to(beTrue())
            }

            it("Should set view controller title") {
                let controller = TODONoteListViewInteractionMock()

                sut.configureFlow(controller, flowController: flowController)

                expect(controller.title).to(equal("TODOs"))
            }

            it("Should assign on add TODO action") {
                let controller = TODONoteListViewInteractionMock()

                sut.configureFlow(controller, flowController: flowController)
                controller.onAddTODO?()

                expect(controller.onAddTODO).toNot(beNil())
                expect(flowController.lastNavigatedTo).toNot(beNil())
                expect(flowController.lastNavigatedTo)
                    .to(be(CreateTODONoteViewController.self))
            }
        }
    }
}
