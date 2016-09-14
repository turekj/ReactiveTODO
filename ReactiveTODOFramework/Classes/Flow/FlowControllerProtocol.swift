import UIKit


public protocol FlowControllerProtocol {

    var rootController: UINavigationController { get }

    func navigateTo<ViewController: UIViewController>(
            viewController: ViewController.Type, animated: Bool)
    func navigateBackTo<ViewController: UIViewController>(
            viewController: ViewController.Type, animated: Bool)
}
