import UIKit


protocol FlowControllerProtocol {

    func navigateTo<ViewController: UIViewController>(
            viewController: ViewController.Type, animated: Bool)
    func navigateBackTo<ViewController: UIViewController>(
            viewController: ViewController.Type, animated: Bool)
}
