import UIKit


class TODONoteListFlowConfigurator: FlowConfigurator {

    func configureFlow(controller: UIViewController,
                       flowController: FlowControllerProtocol) -> Bool {
        guard let c = controller as? TODONoteListViewControllerProtocol else {
            return false
        }

        controller.title = "TODOs"

        return true
    }
}
