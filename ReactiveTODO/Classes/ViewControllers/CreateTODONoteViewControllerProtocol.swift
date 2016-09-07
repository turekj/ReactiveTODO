import Foundation


protocol CreateTODONoteViewControllerProtocol {

    var onSave: ((NSDate, String, Priority) -> Void)? { get set }
}
