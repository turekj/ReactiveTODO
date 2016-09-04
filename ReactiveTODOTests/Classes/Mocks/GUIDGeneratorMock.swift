@testable import ReactiveTODO
import Foundation


class GUIDGeneratorMock: GUIDGeneratorProtocol {
    
    var generatedGUID = "generated_guid"
    
    func generateGUID() -> String {
        return self.generatedGUID
    }
}
