@testable import ReactiveTODO
import Foundation


class TODONoteFactoryMock: TODONoteFactoryProtocol {

    var guid = "GUID"
    var date = NSDate(timeIntervalSince1970: 789)
    var note = "Note"
    var priority = Priority.Medium

    func createTODONote() -> TODONote {
        let note = TODONote()
        note.guid = self.guid
        note.date = self.date
        note.note = self.note
        note.priority = self.priority

        return note
    }
}
