import Foundation
import RealmSwift


public protocol RealmConfigurationFactoryProtocol {
    
    func createRealmConfiguration() -> Realm.Configuration
    func updateDefaultRealmConfiguration()
}
