import UIKit


class TODONoteListFlowConfigurator: FlowConfigurator {

    func configureFlow(controller: UIViewController,
                       flowController: FlowControllerProtocol) -> Bool {
        guard var c = controller as? TODONoteListViewControllerProtocol else {
            return false
        }

        controller.title = "TODOs"

        c.onAddTODO = {
            flowController.navigateTo(CreateTODONoteViewController.self,
                    animated: true)
        }

        return true
    }
}
