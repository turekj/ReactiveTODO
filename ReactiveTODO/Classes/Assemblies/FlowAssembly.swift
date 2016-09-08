import Foundation
import Swinject
import UIKit


class FlowAssembly: AssemblyType {

    func assemble(container: Container) {
        container.register(FlowControllerProtocol.self) { r in
            let configurator = r.resolve(FlowConfigurator.self, name: "main")!
            let rootController = r.resolve(UINavigationController.self,
                    name: "root")!

            return FlowController(container: container,
                    configurator: configurator,
                    rootController: rootController)
        }

        container.register(UINavigationController.self, name: "root") { _ in
            let navigationController = UINavigationController(nibName: nil,
                    bundle: nil)
            navigationController.navigationBar.translucent = false

            return navigationController
        }

        container.register(FlowConfigurator.self, name: "main") { r in
            let todoListConfigurator = r.resolve(FlowConfigurator.self,
                    name: "todoList")!
            let createTODOConfigurator = r.resolve(FlowConfigurator.self,
                    name: "createTODO")!
            let configurators = [todoListConfigurator, createTODOConfigurator]

            return AggregateFlowConfigurator(configurators: configurators)
        }

        container.register(FlowConfigurator.self, name: "todoList") { r in
            let dao = r.resolve(TODONoteDataAccessObjectProtocol.self)!

            return TODONoteListFlowConfigurator(todoNoteDAO: dao)
        }

        container.register(FlowConfigurator.self, name: "createTODO") { r in
            let dao = r.resolve(TODONoteDataAccessObjectProtocol.self)!

            return CreateTODONoteFlowConfigurator(todoNoteDAO: dao)
        }
    }
}
