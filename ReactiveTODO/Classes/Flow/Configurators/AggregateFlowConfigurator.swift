import UIKit


class AggregateFlowConfigurator: FlowConfigurator {

    let configurators: [FlowConfigurator]

    init(configurators: [FlowConfigurator]) {
        self.configurators = configurators
    }

    func configureFlow(controller: UIViewController,
                       flowController: FlowControllerProtocol) -> Bool {
        for configurator in self.configurators {
            if configurator.configureFlow(controller,
                    flowController: flowController) {
                return true
            }
        }

        return false
    }
}
