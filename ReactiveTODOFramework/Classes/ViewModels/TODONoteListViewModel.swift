import Foundation
import ReactiveKit
import RealmSwift


class TODONoteListViewModel {

    let notes: ResultsProperty<TODONote>

    init(notes: Results<TODONote>) {
        self.notes = ResultsProperty(notes)
    }
}
