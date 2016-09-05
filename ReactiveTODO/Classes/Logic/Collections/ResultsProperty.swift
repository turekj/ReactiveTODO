import Foundation
import ReactiveKit
import RealmSwift


class ResultsProperty<C: Object>: CollectionProperty<Results<C>> {

    let results: Results<C>
    var notificationToken: NotificationToken?

    override init(_ results: Results<C>) {
        self.results = results

        super.init(self.results)

        self.startObservingResultsChanges()
    }

    private func startObservingResultsChanges() {
        self.notificationToken = self.results.addNotificationBlock { changes in
            switch changes {
            case .Initial:
                var inserts: [Int] = []
                inserts += 0..<self.results.count

                let changeset = CollectionChangeset(
                        collection: self.results,
                        inserts: inserts,
                        deletes: [],
                        updates: [])

                self.update(changeset)
                break

            case .Update(_, let deletes, let inserts, let updates):
                let changeset = CollectionChangeset(
                        collection: self.results,
                        inserts: inserts,
                        deletes: deletes,
                        updates: updates)

                self.update(changeset)
                break

            case .Error(let error):
                fatalError("\(error)")
                break
            }
        }
    }

    deinit {
        notificationToken?.stop()
    }
}
