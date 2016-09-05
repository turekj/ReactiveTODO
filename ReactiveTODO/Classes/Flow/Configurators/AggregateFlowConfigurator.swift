import UIKit


class AggregateFlowConfigurator: FlowConfigurator {

    let configurators: [FlowConfigurator]

    init(configurators: [FlowConfigurator]) {
        self.configurators = configurators
    }

    func configureFlow(controller: UIViewController) -> Bool {
        for configurator in self.configurators {
            if configurator.configureFlow(controller) {
                return true
            }
        }

        return false
    }
}
