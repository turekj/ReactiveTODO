@testable import ReactiveTODOFramework
import Nimble
import Quick


class CreateTODONoteFlowConfiguratorSpec: QuickSpec {

    override func spec() {
        describe("CreateTODONoteFlowConfigurator") {
            let flowController = FlowControllerMock()
            let dao = TODONoteDataAccessObjectMock()
            let sut = CreateTODONoteFlowConfigurator(todoNoteDAO: dao)

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

            it("Should create a new TODO on save") {
                let controller = CreateTODONoteViewInteractionMock()
                let date = NSDate(timeIntervalSince1970: 3789)
                let note = "SUPERB NOTE"
                let priority = Priority.Low

                sut.configureFlow(controller, flowController: flowController)
                controller.onSave?(date, note, priority)

                expect(controller.onSave).toNot(beNil())
                expect(dao.createdDate).toNot(beNil())
                expect(dao.createdDate)
                    .to(equal(NSDate(timeIntervalSince1970: 3789)))
                expect(dao.createdNote).toNot(beNil())
                expect(dao.createdNote).to(equal("SUPERB NOTE"))
                expect(dao.createdPriority).toNot(beNil())
                expect(dao.createdPriority).to(equal(Priority.Low))
            }
        }
    }
}
