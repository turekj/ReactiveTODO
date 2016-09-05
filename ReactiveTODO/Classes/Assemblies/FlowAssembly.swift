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
            UINavigationController(nibName: nil, bundle: nil)
        }

        container.register(FlowConfigurator.self, name: "main") { r in
            let todoListConfigurator = r.resolve(FlowConfigurator.self,
                    name: "todoList")!
            let configurators = [todoListConfigurator]

            return AggregateFlowConfigurator(configurators: configurators)
        }

        container.register(FlowConfigurator.self, name: "todoList") { _ in
            TODONoteListFlowConfigurator()
        }
    }
}
