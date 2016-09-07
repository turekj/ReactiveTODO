import Foundation
import RealmSwift


protocol TODONoteDataAccessObjectProtocol {

    func createTODONote(date: NSDate, note: String,
                        priority: Priority) -> TODONote

    func getCurrentTODONotes() -> Results<TODONote>
}
