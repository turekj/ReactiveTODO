import Foundation


public protocol CreateTODONoteViewControllerProtocol {

    var onSave: ((NSDate, String, Priority) -> Void)? { get set }
}
