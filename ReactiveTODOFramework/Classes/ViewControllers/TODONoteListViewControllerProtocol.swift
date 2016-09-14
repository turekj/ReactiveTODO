import Foundation


protocol TODONoteListViewControllerProtocol {

    var onAddTODO: (Void -> Void)? { get set }
    var onSelectTODO: (String -> Void)? { get set }
}
