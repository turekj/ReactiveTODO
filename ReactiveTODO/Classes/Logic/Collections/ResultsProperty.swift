import Foundation
import ReactiveKit
import RealmSwift


class ResultsProperty<C: Object>: CollectionProperty<Results<C>> {

    let results: Results<C>

    override init(_ results: Results<C>) {
        self.results = results

        super.init(self.results)
    }
}
