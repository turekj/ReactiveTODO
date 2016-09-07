import Foundation
import Swinject
import UIKit


class GlobalAssembly: AssemblyType {

    func assemble(container: Container) {
        container.register(DateResolverProtocol.self) { _ in
            DateResolver()
        }

        container.register(Validator<NSDate?>.self) { r in
            let dateResolver = r.resolve(DateResolverProtocol.self)!

            return Validator(DateValidator(dateResolver: dateResolver))
        }

        container.register(Validator<String?>.self) { _ in
            return Validator(NoteValidator())
        }

        container.register(Validator<Priority?>.self) { _ in
            return Validator(PriorityValidator())
        }

        container.register(DateFormatterProtocol.self, name: "relative") { _ in
            RelativeDateFormatter()
        }
    }
}
