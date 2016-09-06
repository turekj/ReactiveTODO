import UIKit


protocol FlowConfigurator {

    func configureFlow(controller: UIViewController,
                       flowController: FlowControllerProtocol) -> Bool
}
