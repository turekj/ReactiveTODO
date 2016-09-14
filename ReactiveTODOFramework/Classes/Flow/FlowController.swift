import Swinject
import UIKit


public class FlowController: FlowControllerProtocol {

    public unowned let container: Container
    public let configurator: FlowConfigurator
    public let rootController: UINavigationController

    public init(container: Container,
         configurator: FlowConfigurator,
         rootController: UINavigationController) {
        self.container = container
        self.configurator = configurator
        self.rootController = rootController
    }

    public func navigateTo<ViewController: UIViewController>(
            viewController: ViewController.Type, animated: Bool) {
        guard let controller = self.container.resolve(viewController)
                as? UIViewController else {
            return
        }

        self.configurator.configureFlow(controller, flowController: self)
        self.rootController.pushViewController(controller, animated: animated)
    }

    public func navigateBackTo<ViewController: UIViewController>(
            viewController: ViewController.Type, animated: Bool) {
        for controller in self.rootController.childViewControllers {
            if controller.isKindOfClass(viewController) {
                self.rootController.popToViewController(controller,
                        animated: animated)
            }
        }
    }
}
