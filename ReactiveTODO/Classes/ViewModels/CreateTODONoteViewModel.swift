import Foundation
import ReactiveKit


class CreateTODONoteViewModel {

    let date: Property<NSDate>
    let note: Property<String?>
    let priority: Property<Priority?>

    init(date: NSDate, note: String?, priority: Priority?) {
        self.date = Property(date)
        self.note = Property(note)
        self.priority = Property(priority)
    }
}
