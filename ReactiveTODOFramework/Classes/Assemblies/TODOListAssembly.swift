import Foundation
import Swinject
import UIKit


public class TODOListAssembly: AssemblyType {

    public init() { }
    
    public func assemble(container: Container) {
        container.register(TODONoteListViewController.self) { r in
            let view = r.resolve(TODONoteListView.self)!
            let viewModel = r.resolve(TODONoteListViewModel.self)!
            let cellFactory = r.resolve(TODONoteListCellFactoryProtocol.self)!

            return TODONoteListViewController(view: view,
                    viewModel: viewModel,
                    cellFactory: cellFactory)
        }

        container.register(TODONoteListView.self) { _ in
            TODONoteListView()
        }

        container.register(TODONoteListViewModel.self) { r in
            let factory = r.resolve(TODONoteListViewModelFactoryProtocol.self)!

            return factory.createViewModel()
        }

        container.register(TODONoteListViewModelFactoryProtocol.self) { r in
            let dao = r.resolve(TODONoteDataAccessObjectProtocol.self)!

            return TODONoteListViewModelFactory(todoNoteDAO: dao)
        }

        container.register(TODONoteListCellFactoryProtocol.self) { r in
            let bundle = NSBundle(forClass: TODONoteListCellFactory.self)
            let dateFormatter = r.resolve(DateFormatterProtocol.self,
                    name: "relative")!
            let priorityFormatter = r.resolve(
                    PriorityImageNameFormatterProtocol.self)!

            return TODONoteListCellFactory(bundle: bundle,
                    dateFormatter: dateFormatter,
                    priorityFormatter: priorityFormatter)
        }

        container.register(PriorityImageNameFormatterProtocol.self) { _ in
            PriorityImageNameFormatter()
        }
    }
}
