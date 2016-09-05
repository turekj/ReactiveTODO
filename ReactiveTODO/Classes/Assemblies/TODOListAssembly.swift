import Foundation
import Swinject
import UIKit


class TODOListAssembly: AssemblyType {

    func assemble(container: Container) {
        container.register(TODONoteListViewController.self) { r in
            let view = r.resolve(TODONoteListView.self)!
            let viewModel = r.resolve(TODONoteListViewModel.self)!
            let cellFactory = r.resolve(TODONoteListCellFactoryProtocol.self)!

            return TODONoteListViewController(view: view,
                    viewModel: viewModel,
                    cellFactory: cellFactory)
        }

        container.register(TODONoteListView.self) { _ in
            TODONoteListView(frame: CGRectZero, style: .Plain)
        }

        container.register(TODONoteListViewModel.self) { r in
            let factory = r.resolve(TODONoteListViewModelFactoryProtocol.self)!

            return factory.createViewModel()
        }

        container.register(TODONoteListViewModelFactoryProtocol.self) { _ in
            TODONoteListViewModelFactory()
        }

        container.register(TODONoteListCellFactoryProtocol.self) { r in
            let bundle = NSBundle.mainBundle()
            let dateFormatter = r.resolve(DateFormatterProtocol.self,
                    name: "relative")!
            let priorityFormatter = r.resolve(
                    PriorityImageNameFormatterProtocol.self)!

            return TODONoteListCellFactory(bundle: bundle,
                    dateFormatter: dateFormatter,
                    priorityFormatter: priorityFormatter)
        }

        container.register(DateFormatterProtocol.self, name: "relative") { _ in
            RelativeDateFormatter()
        }

        container.register(PriorityImageNameFormatterProtocol.self) { _ in
            PriorityImageNameFormatter()
        }
    }
}
