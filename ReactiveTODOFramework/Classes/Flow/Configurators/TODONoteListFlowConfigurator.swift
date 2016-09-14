import UIKit


class TODONoteListFlowConfigurator: FlowConfigurator {

    let todoNoteDAO: TODONoteDataAccessObjectProtocol

    init(todoNoteDAO: TODONoteDataAccessObjectProtocol) {
        self.todoNoteDAO = todoNoteDAO
    }

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

        c.onSelectTODO = { guid in
            self.todoNoteDAO.completeTODONote(guid)
        }

        return true
    }
}
