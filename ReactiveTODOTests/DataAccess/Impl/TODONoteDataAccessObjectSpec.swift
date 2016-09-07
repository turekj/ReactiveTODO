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
                it("Should return all notes") {
                    let realm = try! Realm()
                    let note = TODONote()
                    note.guid = "AWESOME_UNIQUE_GUID"
                    note.date = NSDate(timeIntervalSince1970: 1970)
                    note.note = "Awesome Note"
                    note.priority = .Urgent

                    try! realm.write {
                        realm.add(note)
                    }

                    let notes = sut.getCurrentTODONotes()

                    expect(notes.count).to(equal(1))
                    expect(notes.first?.guid).to(equal("AWESOME_UNIQUE_GUID"))
                    expect(notes.first?.date)
                        .to(equal(NSDate(timeIntervalSince1970: 1970)))
                    expect(notes.first?.note).to(equal("Awesome Note"))
                    expect(notes.first?.priority).to(equal(Priority.Urgent))
                }
            }
        }
    }
}
