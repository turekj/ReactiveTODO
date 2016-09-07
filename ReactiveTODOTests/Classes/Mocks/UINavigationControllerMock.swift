import UIKit


class UINavigationControllerMock: UINavigationController {

    var lastPushed: UIViewController?
    var lastPoppedTo: UIViewController?

    override func pushViewController(viewController: UIViewController,
                                     animated: Bool) {
        self.lastPushed = viewController
    }

    override func popToViewController(viewController: UIViewController,
                                      animated: Bool) -> [UIViewController]? {
        self.lastPoppedTo = viewController
        return []
    }
}
