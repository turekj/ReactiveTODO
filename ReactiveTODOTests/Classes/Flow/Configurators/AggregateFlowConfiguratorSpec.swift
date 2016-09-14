@testable import ReactiveTODOFramework
import Nimble
import Quick


class AggregateFlowConfiguratorSpec: QuickSpec {

    override func spec() {
        describe("AggregateFlowConfigurator") {
            it("Should call configurators passing controller") {
                let controller = UIViewController()
                let flowController = FlowControllerMock()
                let firstConfigurator = FlowConfiguratorMock()
                let secondConfigurator = FlowConfiguratorMock()
                let sut = AggregateFlowConfigurator(
                        configurators: [firstConfigurator, secondConfigurator])

                sut.configureFlow(controller, flowController: flowController)

                expect(firstConfigurator.calledWithViewController)
                    .to(be(controller))
                expect(secondConfigurator.calledWithViewController)
                    .to(be(controller))
            }

            it("Should call configurators passing flow controller") {
                let controller = UIViewController()
                let flowController = FlowControllerMock()
                let firstConfigurator = FlowConfiguratorMock()
                let secondConfigurator = FlowConfiguratorMock()
                let sut = AggregateFlowConfigurator(
                        configurators: [firstConfigurator, secondConfigurator])

                sut.configureFlow(controller, flowController: flowController)

                expect(firstConfigurator.calledWithFlowController
                    as? FlowControllerMock).to(be(flowController))
                expect(secondConfigurator.calledWithFlowController
                    as? FlowControllerMock).to(be(flowController))
            }

            it("Should return false if all children return false") {
                let firstConfigurator = FlowConfiguratorMock()
                firstConfigurator.configureFlowReturnValue = false
                let secondConfigurator = FlowConfiguratorMock()
                secondConfigurator.configureFlowReturnValue = false
                let sut = AggregateFlowConfigurator(
                        configurators: [firstConfigurator, secondConfigurator])

                let result = sut.configureFlow(UIViewController(),
                        flowController: FlowControllerMock())

                expect(result).to(beFalse())
            }

            it("Should return true if any of the children returns true") {
                let firstConfigurator = FlowConfiguratorMock()
                firstConfigurator.configureFlowReturnValue = false
                let secondConfigurator = FlowConfiguratorMock()
                secondConfigurator.configureFlowReturnValue = true
                let sut = AggregateFlowConfigurator(
                        configurators: [firstConfigurator, secondConfigurator])

                let result = sut.configureFlow(UIViewController(),
                        flowController: FlowControllerMock())

                expect(result).to(beTrue())
            }
        }
    }
}
