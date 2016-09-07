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

            it("Should navigate back to notes list on save") {
                let controller = CreateTODONoteViewInteractionMock()
                let date = NSDate(timeIntervalSince1970: 222)
                let note = "Note"
                let priority = Priority.Urgent

                sut.configureFlow(controller, flowController: flowController)
                controller.onSave?(date, note, priority)

                expect(controller.onSave).toNot(beNil())
                expect(flowController.lastNavigatedBackTo).toNot(beNil())
                expect(flowController.lastNavigatedBackTo)
                    .to(be(TODONoteListViewController.self))
            }
        }
    }
}
