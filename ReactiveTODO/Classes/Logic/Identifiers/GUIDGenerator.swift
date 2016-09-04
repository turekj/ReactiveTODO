import Foundation


protocol GUIDGeneratorProtocol {
    
    func generateGUID() -> String
}


class GUIDGenerator: GUIDGeneratorProtocol {
    
    func generateGUID() -> String {
        let uuid = NSUUID().UUIDString.lowercaseString
        return uuid.stringByReplacingOccurrencesOfString("-", withString: "")
    }
}
