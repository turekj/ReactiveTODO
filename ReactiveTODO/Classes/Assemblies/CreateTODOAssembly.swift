import Foundation
import Swinject


class CreateTODOAssembly: AssemblyType {

    func assemble(container: Container) {
        container.register(CreateTODONoteViewController.self) { r in
            let view = r.resolve(CreateTODONoteView.self)!
            let viewModel = r.resolve(CreateTODONoteViewModel.self)!

            return CreateTODONoteViewController(view: view,
                    viewModel: viewModel)
        }

        container.register(CreateTODONoteView.self) { _ in
            CreateTODONoteView()
        }

        container.register(CreateTODONoteViewModel.self) { _ in
            CreateTODONoteViewModel()
        }
    }
}
