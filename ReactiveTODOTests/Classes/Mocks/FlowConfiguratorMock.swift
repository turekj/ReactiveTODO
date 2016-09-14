@testable import ReactiveTODOFramework
import UIKit


class FlowConfiguratorMock: FlowConfigurator {

    var configureFlowReturnValue = false
    var calledWithViewController: UIViewController?
    var calledWithFlowController: FlowControllerProtocol?

    func configureFlow(controller: UIViewController,
                       flowController: FlowControllerProtocol) -> Bool {
        self.calledWithViewController = controller
        self.calledWithFlowController = flowController
        return self.configureFlowReturnValue
    }
}
