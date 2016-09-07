import Cartography
import ReactiveKit
import ReactiveUIKit
import UIKit


class TODONoteListViewController: UIViewController,
        TODONoteListViewControllerProtocol {

    let notesView: TODONoteListView
    let viewModel: TODONoteListViewModel
    let cellFactory: TODONoteListCellFactoryProtocol

    var onAddTODO: (Void -> Void)?
    var onSelectTODO: (String -> Void)?

    init(view: TODONoteListView, viewModel: TODONoteListViewModel,
         cellFactory: TODONoteListCellFactoryProtocol) {
        self.notesView = view
        self.viewModel = viewModel
        self.cellFactory = cellFactory

        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureView()
        self.bindViewModel()
    }

    func configureView() {
        self.view.addSubview(self.notesView)

        constrain(self.notesView) { v in
            v.edges == v.superview!.edges
        }
    }

    func bindViewModel() {
        self.bindAddTODONoteButton()
        self.bindTODONotesList()
        self.bindRowSelection()
    }

    func bindAddTODONoteButton() {
        self.notesView.addButton.rTap.observeNext { [unowned self] _ in
            self.onAddTODO?()
        }.disposeIn(self.rBag)
    }

    func bindTODONotesList() {
        self.viewModel.notes.bindTo(self.notesView.list) {
                indexPath, notes, list in
            let note = notes[indexPath.row]
            let cell = list.dequeueReusableCellWithIdentifier(
                    ReuseIdentifiers.TODOListCell) as! TODONoteListCell

            return self.cellFactory.configureCell(cell, note: note)
        }
    }

    func bindRowSelection() {
        self.notesView.list.selectedRow
            .observeIn(ImmediateOnMainExecutionContext)
            .observeNext { [unowned self] index in
                let guid = self.viewModel.notes[index].guid
                self.onSelectTODO?(guid)
            }.disposeIn(self.rBag)
    }

    // MARK: - Required init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
