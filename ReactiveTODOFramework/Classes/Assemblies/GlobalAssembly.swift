import Foundation
import Swinject
import UIKit


public class GlobalAssembly: AssemblyType {
    
    public init() { }

    public func assemble(container: Container) {
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

        container.register(TODONoteDataAccessObjectProtocol.self) { r in
            let factory = r.resolve(TODONoteFactoryProtocol.self)!

            return TODONoteDataAccessObject(factory: factory)
        }

        container.register(TODONoteFactoryProtocol.self) { r in
            let dateResolver = r.resolve(DateResolverProtocol.self)!
            let guidGenerator = r.resolve(GUIDGeneratorProtocol.self)!

            return TODONoteFactory(dateResolver: dateResolver,
                    guidGenerator: guidGenerator)
        }

        container.register(GUIDGeneratorProtocol.self) { _ in
            GUIDGenerator()
        }
    }
}
