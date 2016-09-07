@testable import ReactiveTODO
import Foundation
import RealmSwift


class TODONoteDataAccessObjectMock: TODONoteDataAccessObjectProtocol {

    var targetGuid = ""

    func createTODONote(date: NSDate, note: String,
                        priority: Priority) -> TODONote {
        return TODONote()
    }

    func getCurrentTODONotes() -> Results<TODONote> {
        let realm = try! Realm()

        return realm.objects(TODONote.self)
            .filter("guid = '\(self.targetGuid)'")
    }
}
