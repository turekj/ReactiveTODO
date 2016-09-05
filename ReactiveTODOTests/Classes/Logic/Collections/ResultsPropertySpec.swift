@testable import ReactiveTODO
import Foundation
import Nimble
import Quick
import ReactiveKit
import RealmSwift


class ResultsPropertySpec: QuickSpec {
    override func spec() {
        describe("ResultsProperty") {
            Realm.Configuration
                .defaultConfiguration
                .inMemoryIdentifier = self.name

            afterEach {
                let realm = try! Realm()

                try! realm.write {
                    realm.deleteAll()
                }
            }

            it("Should subscribe to update event") {
                let realm = try! Realm()
                let results = realm.objects(TODONote.self)
                var inserts: [Int] = []
                var updates: [Int] = []
                var deletes: [Int] = []
                let firstTodo = TODONote()
                firstTodo.guid = "1st"
                let secondTodo = TODONote()
                secondTodo.guid = "2nd"

                let resultsProperty = ResultsProperty(results)
                resultsProperty.observeNext { c in
                    inserts.appendContentsOf(c.inserts)
                    updates.appendContentsOf(c.updates)
                    deletes.appendContentsOf(c.deletes)
                }.disposeIn(firstTodo.rBag)

                delay(0.1) {
                    try! realm.write {
                        realm.add(firstTodo)
                    }
                }

                delay(0.2) {
                    try! realm.write {
                        realm.add(secondTodo)
                    }
                }

                delay(0.3) {
                    try! realm.write {
                        secondTodo.priority = .High
                    }
                }

                delay(0.4) {
                    try! realm.write {
                        realm.delete(firstTodo)
                    }
                }

                expect(inserts).toEventually(equal([0, 1]))
                expect(updates).toEventually(equal([1]))
                expect(deletes).toEventually(equal([0]))
            }

            it("Should subscribe to initial event") {
                let realm = try! Realm()
                let results = realm.objects(TODONote.self)
                var inserts: [Int] = []
                var updates: [Int] = []
                var deletes: [Int] = []
                let firstTodo = TODONote()
                firstTodo.guid = "1st"
                let secondTodo = TODONote()
                secondTodo.guid = "2nd"

                let resultsProperty = ResultsProperty(results)
                resultsProperty.observeNext { c in
                    inserts.appendContentsOf(c.inserts)
                    updates.appendContentsOf(c.updates)
                    deletes.appendContentsOf(c.deletes)
                }.disposeIn(firstTodo.rBag)

                try! realm.write {
                    realm.add(firstTodo)
                }

                try! realm.write {
                    realm.add(secondTodo)
                }

                try! realm.write {
                    realm.delete(firstTodo)
                }

                expect(inserts).toEventually(equal([0]))
                expect(updates).toEventually(equal([]))
                expect(deletes).toEventually(equal([]))
            }
        }
    }
}
