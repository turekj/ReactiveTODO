import Swinject
import UIKit


class RootNavigationController: UINavigationController,
        RootNavigationControllerProtocol {

    weak var container: Container?

    init(container: Container) {
        self.container = container

        super.init(nibName: nil, bundle: nil)
    }

    func navigateToViewController<ViewController: UIViewController>(
            controllerType: ViewController.Type, animated: Bool) {

    }

    func navigateBackToRootViewController(animated: Bool) {

    }

    // MARK: - Required init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
