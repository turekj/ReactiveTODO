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

            it("Should notify about collection changes") {
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
                }.disposeIn(self.rBag)

                try! realm.write {
                    realm.add(firstTodo)
                    realm.add(secondTodo)

                    secondTodo.priority = .High

                    realm.delete(firstTodo)
                }

                expect(inserts).toEventually(equal([0, 1]))
                expect(updates).toEventually(equal([1]))
                expect(deletes).toEventually(equal([0]))
            }
        }
    }
}
