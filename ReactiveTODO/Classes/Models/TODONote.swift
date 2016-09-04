import Foundation
import RealmSwift


class TODONote: Object {

    dynamic var guid: String = ""
    dynamic var note: String = ""
    dynamic var date: NSDate = NSDate(timeIntervalSince1970: 1)
    
    override static func primaryKey() -> String? {
        return "guid"
    }
}
