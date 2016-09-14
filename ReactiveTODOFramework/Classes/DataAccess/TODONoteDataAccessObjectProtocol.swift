import Foundation
import RealmSwift


protocol TODONoteDataAccessObjectProtocol {

    func getNote(guid: String) -> TODONote?
    func getCurrentTODONotes() -> Results<TODONote>
    
    func createTODONote(date: NSDate, note: String,
                        priority: Priority) -> TODONote
    
    func completeTODONote(guid: String)
}
