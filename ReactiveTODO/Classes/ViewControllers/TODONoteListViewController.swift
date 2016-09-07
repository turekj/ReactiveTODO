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
    }

    func bindAddTODONoteButton() {
        self.notesView.addButton.rTap.observeNext { [unowned self] _ in
            self.onAddTODO?()
        }.disposeIn(self.rBag)
    }

    func bindTODONotesList() {
        self.viewModel.notes.bindTo(self.notesView.list) {
                [unowned self] indexPath, notes, list in
            let note = notes[indexPath.row]
            let cell = list.dequeueReusableCellWithIdentifier(
                    ReuseIdentifiers.TODOListCell) as! TODONoteListCell

            return self.cellFactory.configureCell(cell, note: note)
        }
    }

    // MARK: - Required init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
