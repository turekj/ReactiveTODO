import Foundation
import RealmSwift


public class TODONote: Object {

    dynamic var guid = ""
    dynamic var note = ""
    dynamic var date = NSDate(timeIntervalSince1970: 1)
    dynamic var completed = false
    private dynamic var priorityRaw = ""
    
    var priority: Priority {
        get {
            return Priority(rawValue: self.priorityRaw)!
        }
        set {
            self.priorityRaw = newValue.rawValue
        }
    }
    
    override static public func primaryKey() -> String? {
        return "guid"
    }
}
