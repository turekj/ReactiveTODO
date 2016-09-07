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

            it("Should subscribe to update event") {
                let realm = try! Realm()
                let results = realm.objects(FakeRealmObject.self)
                var inserts: [Int] = []
                var updates: [Int] = []
                var deletes: [Int] = []
                let firstObject = FakeRealmObject()
                firstObject.guid = "1st"
                let secondObject = FakeRealmObject()
                secondObject.guid = "2nd"

                let resultsProperty = ResultsProperty(results)
                resultsProperty.observeNext { c in
                    inserts.appendContentsOf(c.inserts)
                    updates.appendContentsOf(c.updates)
                    deletes.appendContentsOf(c.deletes)
                }.disposeIn(firstObject.rBag)

                delay(0.1) {
                    try! realm.write {
                        realm.add(firstObject)
                    }
                }

                delay(0.2) {
                    try! realm.write {
                        realm.add(secondObject)
                    }
                }

                delay(0.3) {
                    try! realm.write {
                        secondObject.someProperty = "Property"
                    }
                }

                delay(0.4) {
                    try! realm.write {
                        realm.delete(firstObject)
                    }
                }

                expect(inserts).toEventually(equal([0, 1]))
                expect(updates).toEventually(equal([1]))
                expect(deletes).toEventually(equal([0]))
            }

            it("Should not subscribe to initial event") {
                let realm = try! Realm()
                let results = realm.objects(FakeRealmObject.self)
                var inserts: [Int] = []
                var updates: [Int] = []
                var deletes: [Int] = []
                let firstObject = FakeRealmObject()
                firstObject.guid = "1st"
                let secondObject = FakeRealmObject()
                secondObject.guid = "2nd"

                let resultsProperty = ResultsProperty(results)
                resultsProperty.observeNext { c in
                    inserts.appendContentsOf(c.inserts)
                    updates.appendContentsOf(c.updates)
                    deletes.appendContentsOf(c.deletes)
                }.disposeIn(firstObject.rBag)

                try! realm.write {
                    realm.add(firstObject)
                }

                try! realm.write {
                    realm.add(secondObject)
                }

                try! realm.write {
                    realm.delete(firstObject)
                }

                expect(inserts).toEventually(equal([]))
                expect(updates).toEventually(equal([]))
                expect(deletes).toEventually(equal([]))
            }
        }
    }
}
