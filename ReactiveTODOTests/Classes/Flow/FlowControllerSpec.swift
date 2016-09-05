@testable import ReactiveTODO
import Nimble
import Quick
import Swinject


class FlowControllerSpec: QuickSpec {

    override func spec() {
        describe("FlowControllerSpec") {
            let container = Container() { c in
                c.register(ViewControllerMock.self) { _ in
                    ViewControllerMock(nibName: nil, bundle: nil)
                }.inObjectScope(.Hierarchy)
            }

            let configurator = FlowConfiguratorMock()
            let rootController = UINavigationControllerMock(nibName: nil,
                    bundle: nil)
            let sut = FlowController(container: container,
                    configurator: configurator, rootController: rootController)

            context("When navigating forward") {
                let controller = container.resolve(ViewControllerMock.self)!

                sut.navigateTo(ViewControllerMock.self, animated: true)

                it("Should call configurator for a view controller") {
                    expect(configurator.calledWithViewController)
                        .toNot(beNil())
                    expect(configurator.calledWithViewController)
                        .to(be(controller))
                }

                it("Should pass self as a flow controller") {
                    expect(configurator.calledWithFlowController)
                        .toNot(beNil())
                    expect(configurator.calledWithFlowController
                        as? FlowController).to(be(sut))
                }

                it("Should push controller on a stack") {
                    expect(rootController.lastPushed).toNot(beNil())
                    expect(rootController.lastPushed).to(be(controller))
                }
            }

            context("When navigating backwards") {
                let controller = container.resolve(ViewControllerMock.self)!
                rootController.setViewControllers([controller], animated: true)

                sut.navigateBackTo(ViewControllerMock.self, animated: true)

                it("Should push back to a found instance") {
                    expect(rootController.lastPoppedTo).toNot(beNil())
                    expect(rootController.lastPoppedTo).to(be(controller))
                }
            }
        }
    }
}
