@testable import ReactiveTODO
import Nimble
import Quick


class AggregateFlowConfiguratorSpec: QuickSpec {

    override func spec() {
        describe("AggregateFlowConfigurator") {
            it("Should call configurators passing controller") {
                let controller = UIViewController()
                let firstConfigurator = FlowConfiguratorMock()
                let secondConfigurator = FlowConfiguratorMock()
                let sut = AggregateFlowConfigurator(
                        configurators: [firstConfigurator, secondConfigurator])

                sut.configureFlow(controller)

                expect(firstConfigurator.calledWith).to(be(controller))
                expect(secondConfigurator.calledWith).to(be(controller))
            }

            it("Should return false if all children return false") {
                let firstConfigurator = FlowConfiguratorMock()
                firstConfigurator.configureFlowReturnValue = false
                let secondConfigurator = FlowConfiguratorMock()
                secondConfigurator.configureFlowReturnValue = false
                let sut = AggregateFlowConfigurator(
                        configurators: [firstConfigurator, secondConfigurator])

                let result = sut.configureFlow(UIViewController())

                expect(result).to(beFalse())
            }

            it("Should return true if any of the children returns true") {
                let firstConfigurator = FlowConfiguratorMock()
                firstConfigurator.configureFlowReturnValue = false
                let secondConfigurator = FlowConfiguratorMock()
                secondConfigurator.configureFlowReturnValue = true
                let sut = AggregateFlowConfigurator(
                        configurators: [firstConfigurator, secondConfigurator])

                let result = sut.configureFlow(UIViewController())

                expect(result).to(beTrue())
            }
        }
    }
}
