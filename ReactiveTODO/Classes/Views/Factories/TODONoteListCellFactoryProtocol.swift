import Foundation


protocol TODONoteListCellFactoryProtocol {

    func configureCell(cell: TODONoteListCell,
                       note: TODONote) -> TODONoteListCell
}
