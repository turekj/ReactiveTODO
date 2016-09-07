@testable import ReactiveTODO
import UIKit


class CreateTODONoteViewInteractionMock: UIViewController,
        CreateTODONoteViewControllerProtocol {

    var onSave: ((NSDate, String, Priority) -> Void)?
}
