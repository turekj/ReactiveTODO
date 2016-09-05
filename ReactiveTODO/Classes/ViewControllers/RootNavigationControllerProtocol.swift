import UIKit


protocol RootNavigationControllerProtocol {

    func navigateToViewController<ViewController: UIViewController>(
            controllerType: ViewController.Type, animated: Bool)
    func navigateBackToRootViewController(animated: Bool)
}
