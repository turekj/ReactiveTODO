@testable import ReactiveTODO
import UIKit


class FlowConfiguratorMock: FlowConfigurator {

    var configureFlowReturnValue = false
    var calledWith: UIViewController?

    func configureFlow(controller: UIViewController) -> Bool {
        self.calledWith = controller
        return self.configureFlowReturnValue
    }
}
