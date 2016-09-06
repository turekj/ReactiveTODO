import UIKit


class CreateTODONoteFlowConfigurator: FlowConfigurator {

    func configureFlow(controller: UIViewController,
                       flowController: FlowControllerProtocol) -> Bool {
        guard var c = controller as? CreateTODONoteViewControllerProtocol else {
            return false
        }

        controller.title = "Add TODO"

        return true
    }
}
