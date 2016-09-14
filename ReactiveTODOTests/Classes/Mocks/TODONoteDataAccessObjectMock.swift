@testable import ReactiveTODOFramework
import Foundation
import RealmSwift


class TODONoteDataAccessObjectMock: TODONoteDataAccessObjectProtocol {

    var targetGuid = ""

    var createdDate: NSDate?
    var createdNote: String?
    var createdPriority: Priority?

    var completedGuid: String?
    
    var resolvedNote: TODONote?
    var resolvedNoteGuid: String?
    
    func getNote(guid: String) -> TODONote? {
        self.resolvedNoteGuid = guid
        return self.resolvedNote
    }
    
    func getCurrentTODONotes() -> Results<TODONote> {
        let realm = try! Realm()
        
        return realm.objects(TODONote.self)
            .filter("guid = '\(self.targetGuid)'")
    }

    func createTODONote(date: NSDate, note: String,
                        priority: Priority) -> TODONote {
        self.createdDate = date
        self.createdNote = note
        self.createdPriority = priority

        return TODONote()
    }

    func completeTODONote(guid: String) {
        self.completedGuid = guid
    }
}
