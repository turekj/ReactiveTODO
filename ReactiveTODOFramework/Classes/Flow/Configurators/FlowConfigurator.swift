import UIKit


public protocol FlowConfigurator {

    func configureFlow(controller: UIViewController,
                       flowController: FlowControllerProtocol) -> Bool
}
