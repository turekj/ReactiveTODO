import UIKit


class TODONoteListFlowConfigurator: FlowConfigurator {

    func configureFlow(controller: UIViewController) -> Bool {
        guard let c = controller as? TODONoteListViewControllerProtocol else {
            return false
        }

        return true
    }
}
