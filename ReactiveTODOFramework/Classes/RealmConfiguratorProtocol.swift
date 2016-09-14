import Foundation
import RealmSwift


protocol RealmConfigurationFactoryProtocol {
    
    func createRealmConfiguration() -> Realm.Configuration
    func updateDefaultRealmConfiguration()
}
