@testable import ReactiveTODO
import UIKit


class FlowControllerMock: FlowControllerProtocol {

    let rootController: UINavigationController
    var lastNavigatedTo: AnyClass?
    var lastNavigatedBackTo: AnyClass?

    init() {
        self.rootController = UINavigationController(nibName: nil, bundle: nil)
    }

    func navigateTo<ViewController: UIViewController>(
            viewController: ViewController.Type, animated: Bool) {
        self.lastNavigatedTo = viewController
    }

    func navigateBackTo<ViewController:UIViewController>(
            viewController: ViewController.Type, animated: Bool) {
        self.lastNavigatedBackTo = viewController
    }
}
