@testable import ReactiveTODOFramework
import UIKit


class CreateTODONoteViewInteractionMock: UIViewController,
        CreateTODONoteViewControllerProtocol {

    var onSave: ((NSDate, String, Priority) -> Void)?
}
