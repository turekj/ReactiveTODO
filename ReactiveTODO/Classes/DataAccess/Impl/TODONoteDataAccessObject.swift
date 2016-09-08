import Foundation
import RealmSwift


class TODONoteDataAccessObject: TODONoteDataAccessObjectProtocol {

    let factory: TODONoteFactoryProtocol

    init(factory: TODONoteFactoryProtocol) {
        self.factory = factory
    }

    func createTODONote(date: NSDate, note: String,
                        priority: Priority) -> TODONote {
        let noteModel = self.factory.createTODONote()
        noteModel.date = date
        noteModel.note = note
        noteModel.priority = priority

        let realm = try! Realm()

        try! realm.write {
            realm.add(noteModel)
        }

        return noteModel
    }

    func getCurrentTODONotes() -> Results<TODONote> {
        let realm = try! Realm()
        return realm.objects(TODONote.self)
            .filter("completed == NO")
            .sorted("date", ascending: true)
    }

    func completeTODONote(guid: String) {
        self.updateTODONote(guid, updates: ["completed": true])
    }

    func updateTODONote(guid: String, updates: [String: AnyObject]) {
        let realm = try! Realm()
        var todoUpdates = updates
        todoUpdates["guid"] = guid

        try! realm.write {
            realm.create(TODONote.self, value: todoUpdates, update: true)
        }
    }
}
