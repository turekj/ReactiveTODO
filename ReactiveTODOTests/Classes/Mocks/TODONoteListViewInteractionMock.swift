@testable import ReactiveTODO
import UIKit


class TODONoteListViewInteractionMock: UIViewController,
        TODONoteListViewControllerProtocol {

    var onAddTODO: (Void -> Void)?
    var onSelectTODO: (String -> Void)?
}
