import Foundation


class NSFileManagerMock: NSFileManager {
    
    var containerURLForAppGroup: NSURL?
    var passedGroupIdentifier: String?
    
    override func containerURLForSecurityApplicationGroupIdentifier(
            groupIdentifier: String) -> NSURL? {
        self.passedGroupIdentifier = groupIdentifier
        
        return self.containerURLForAppGroup
    }
}
