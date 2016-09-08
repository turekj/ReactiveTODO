@testable import ReactiveTODO
import Nimble
import Quick
import RealmSwift


class TODONoteDataAccessObjectSpec: QuickSpec {

    override func spec() {
        describe("TODONoteDataAccessObject") {
            Realm.Configuration
                .defaultConfiguration
                .inMemoryIdentifier = self.name

            beforeEach {
                let realm = try! Realm()

                try! realm.write {
                    realm.deleteAll()
                }
            }

            afterEach {
                let realm = try! Realm()

                try! realm.write {
                    realm.deleteAll()
                }
            }

            let factory = TODONoteFactoryMock()
            let sut = TODONoteDataAccessObject(factory: factory)

            context("When creating a TODONote") {
                it("Should save created note in database") {
                    let realm = try! Realm()
                    factory.guid = "FACTORY_GUID"
                    factory.completed = true

                    sut.createTODONote(NSDate(timeIntervalSince1970: 444),
                            note: "Creanote", priority: Priority.Urgent)

                    expect(realm.objects(TODONote.self).count).to(equal(1))
                    expect(realm.objects(TODONote.self).first).toNot(beNil())
                    expect(realm.objects(TODONote.self).first?.guid)
                        .to(equal("FACTORY_GUID"))
                    expect(realm.objects(TODONote.self).first?.date)
                        .to(equal(NSDate(timeIntervalSince1970: 444)))
                    expect(realm.objects(TODONote.self).first?.note)
                        .to(equal("Creanote"))
                    expect(realm.objects(TODONote.self).first?.priority)
                        .to(equal(Priority.Urgent))
                    expect(realm.objects(TODONote.self).first?.completed)
                        .to(beTrue())
                }

                it("Should return created note") {
                    factory.guid = "CREATED_GUID"
                    factory.completed = true

                    let result = sut.createTODONote(
                            NSDate(timeIntervalSince1970: 444),
                            note: "Creanote",
                            priority: Priority.Urgent)

                    expect(result.guid).to(equal("CREATED_GUID"))
                    expect(result.note).to(equal("Creanote"))
                    expect(result.date).to(
                            equal(NSDate(timeIntervalSince1970: 444)))
                    expect(result.priority).to(equal(Priority.Urgent))
                    expect(result.completed).to(beTrue())
                }
            }

            context("When returning current TODONotes") {
                it("Should return notes that are not complete") {
                    let realm = try! Realm()
                    let completedNote = TODONote()
                    completedNote.guid = "AWESOME_UNIQUE_GUID"
                    completedNote.date = NSDate(timeIntervalSince1970: 1970)
                    completedNote.note = "Awesome Note"
                    completedNote.priority = .Urgent
                    completedNote.completed = true
                    let notCompletedNote = TODONote()
                    notCompletedNote.guid = "AWESOME_UNIQUE_GUID_NOT_COMPLETED"
                    notCompletedNote.date = NSDate(timeIntervalSince1970: 111)
                    notCompletedNote.note = "Awesome Not Completed Note"
                    notCompletedNote.priority = .Low
                    notCompletedNote.completed = false

                    try! realm.write {
                        realm.add(completedNote)
                        realm.add(notCompletedNote)
                    }

                    let notes = sut.getCurrentTODONotes()

                    expect(notes.count).to(equal(1))
                    expect(notes.first?.guid)
                        .to(equal("AWESOME_UNIQUE_GUID_NOT_COMPLETED"))
                    expect(notes.first?.date)
                        .to(equal(NSDate(timeIntervalSince1970: 111)))
                    expect(notes.first?.note)
                        .to(equal("Awesome Not Completed Note"))
                    expect(notes.first?.priority).to(equal(Priority.Low))
                    expect(notes.first?.completed).to(beFalse())
                }

                it("Should order notes by ascending date") {
                    let realm = try! Realm()
                    let firstNote = TODONote()
                    firstNote.guid = "note_1_date"
                    firstNote.date = NSDate(timeIntervalSince1970: 222)
                    firstNote.note = "Note One"
                    firstNote.priority = .Urgent
                    firstNote.completed = false
                    let secondNote = TODONote()
                    secondNote.guid = "note_2_date"
                    secondNote.date = NSDate(timeIntervalSince1970: 111)
                    secondNote.note = "Note Two"
                    secondNote.priority = .Urgent
                    secondNote.completed = false

                    try! realm.write {
                        realm.add(firstNote)
                        realm.add(secondNote)
                    }

                    let notes = sut.getCurrentTODONotes()

                    expect(notes.count).to(equal(2))
                    expect(notes.first?.guid)
                        .to(equal("note_2_date"))
                    expect(notes.last?.guid)
                        .to(equal("note_1_date"))
                }
            }

            context("When marking note as completed") {
                it("Should set completed flag to true") {
                    let realm = try! Realm()
                    let note = TODONote()
                    note.guid = "completed_test_guid"
                    note.date = NSDate(timeIntervalSince1970: 222)
                    note.note = "Note to complete"
                    note.priority = .Urgent
                    note.completed = false

                    try! realm.write {
                        realm.add(note)
                    }

                    sut.completeTODONote("completed_test_guid")
                    let noteQuery = realm.objects(TODONote.self)
                        .filter("guid = 'completed_test_guid'")

                    expect(noteQuery.count).to(equal(1))
                    expect(noteQuery.first?.guid)
                        .to(equal("completed_test_guid"))
                    expect(noteQuery.first?.completed).to(beTrue())
                }
            }
        }
    }
}
