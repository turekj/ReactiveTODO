import Foundation
import RealmSwift


class FakeRealmObject: Object {
    
    dynamic var guid = ""
    dynamic var someProperty = ""
    
    override static func primaryKey() -> String? {
        return "guid"
    }
}
