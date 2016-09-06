import Foundation
import Swinject
import UIKit


class GlobalAssembly: AssemblyType {

    func assemble(container: Container) {
        container.register(DateResolverProtocol.self) { _ in
            DateResolver()
        }
    }
}
