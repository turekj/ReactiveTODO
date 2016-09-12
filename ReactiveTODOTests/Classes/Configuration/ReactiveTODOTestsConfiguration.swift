import Foundation
import Quick
import RealmSwift


class ReactiveTODOTestsConfiguration: QuickConfiguration {

    override class func configure(configuration: Quick.Configuration!) {
        super.configure(configuration)

        configuration.beforeEach { (metadata: ExampleMetadata) -> Void in
            Realm.Configuration
                .defaultConfiguration
                .inMemoryIdentifier = metadata.example.name

            let realm = try! Realm()

            try! realm.write {
                realm.deleteAll()
            }
        }

        configuration.afterEach {
            let realm = try! Realm()

            try! realm.write {
                realm.deleteAll()
            }
        }
    }
}
