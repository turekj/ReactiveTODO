import UIKit


class CreateTODONoteFlowConfigurator: FlowConfigurator {

    let todoNoteDAO: TODONoteDataAccessObjectProtocol

    init(todoNoteDAO: TODONoteDataAccessObjectProtocol) {
        self.todoNoteDAO = todoNoteDAO
    }

    func configureFlow(controller: UIViewController,
                       flowController: FlowControllerProtocol) -> Bool {
        guard var c = controller as? CreateTODONoteViewControllerProtocol else {
            return false
        }

        controller.title = "Add TODO"

        c.onSave = { [unowned self] date, note, priority in
            self.todoNoteDAO.createTODONote(date,
                    note: note, priority: priority)

            flowController.navigateBackTo(TODONoteListViewController.self,
                    animated: true)
        }

        return true
    }
}
