import Foundation
import RealmSwift


public class AppGroupRealmConfigurationFactory: RealmConfigurationFactoryProtocol {
    
    let appGroupIdentifier: String
    let fileManager: NSFileManager
    
    public init(appGroupIdentifier: String, fileManager: NSFileManager) {
        self.appGroupIdentifier = appGroupIdentifier
        self.fileManager = fileManager
    }
    
    public func createRealmConfiguration() -> Realm.Configuration {
        let databaseDirectoryPath = self.fileManager
            .containerURLForSecurityApplicationGroupIdentifier(self.appGroupIdentifier)!
        let databasePath = databaseDirectoryPath.URLByAppendingPathComponent("database.realm")
        
        return Realm.Configuration(fileURL: databasePath)
    }
    
    public func updateDefaultRealmConfiguration() {
        Realm.Configuration.defaultConfiguration = self.createRealmConfiguration()
    }
}
