@testable import ReactiveTODOFramework
import Foundation
import Nimble
import Quick
import RealmSwift


class AppGroupRealmConfigurationFactorySpec: QuickSpec {
    
    override func spec() {
        describe("AppGroupRealmConfigurationFactory") {
            let fileManager = NSFileManagerMock()
            let appGroup = "group.app.group"
            let sut = AppGroupRealmConfigurationFactory(appGroupIdentifier: appGroup,
                                                        fileManager: fileManager)
            
            context("When creating a configuration") {
                it("Should set default realm path properly") {
                    fileManager.containerURLForAppGroup = NSURL(string: "/some/path")
                    
                    let configuration = sut.createRealmConfiguration()
                    
                    expect(configuration.fileURL).toNot(beNil())
                    expect(configuration.fileURL?.absoluteString).to(
                        equal("file:///some/path/database.realm"))
                }
                
                it("Should pass app group identifier properly") {
                    sut.createRealmConfiguration()
                    
                    expect(fileManager.passedGroupIdentifier).toNot(beNil())
                    expect(fileManager.passedGroupIdentifier).to(equal("group.app.group"))
                }
            }
            
            context("When updating a default configuration") {
                it("Should assign created configuration to .defaultConfiguration") {
                    fileManager.containerURLForAppGroup = NSURL(string: "/default")
                    
                    sut.updateDefaultRealmConfiguration()
                    
                    expect(Realm.Configuration.defaultConfiguration.fileURL).toNot(beNil())
                    expect(Realm.Configuration.defaultConfiguration.fileURL?.absoluteString).to(
                        equal("file:///default/database.realm"))
                    
                    Realm.Configuration.defaultConfiguration.inMemoryIdentifier = self.name
                }
            }
        }
    }
}
