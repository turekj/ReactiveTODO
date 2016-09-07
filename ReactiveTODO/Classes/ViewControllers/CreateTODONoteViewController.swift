import Cartography
import ReactiveKit
import ReactiveUIKit
import UIKit


class CreateTODONoteViewController: UIViewController,
        CreateTODONoteViewControllerProtocol {

    let createView: CreateTODONoteView
    let viewModel: CreateTODONoteViewModel
    let dateValidator: Validator<NSDate?>
    let noteValidator: Validator<String?>
    let priorityValidator: Validator<Priority?>

    var onSave: (Void -> Void)?

    init(view: CreateTODONoteView,
         viewModel: CreateTODONoteViewModel,
         dateValidator: Validator<NSDate?>,
         noteValidator: Validator<String?>,
         priorityValidator: Validator<Priority?>) {
        self.createView = view
        self.viewModel = viewModel
        self.dateValidator = dateValidator
        self.noteValidator = noteValidator
        self.priorityValidator = priorityValidator

        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureSaveButton()
        self.configureView()
        self.bindViewModel()
    }

    func configureSaveButton() {
        let button = UIBarButtonItem(title: "Save", style: .Plain,
                target: self, action: #selector(saveButtonPressed(_:)))
        self.navigationItem.rightBarButtonItem = button
    }

    func saveButtonPressed(sender: UIBarButtonItem) {
        self.onSave?()
    }

    func configureView() {
        self.view.addSubview(self.createView)

        constrain(self.createView) { v in
            v.edges == v.superview!.edges
        }
    }

    func bindViewModel() {
        self.bindSaveButtonEnabled()
    }

    func bindSaveButtonEnabled() {
        guard let saveButton = self.navigationItem.rightBarButtonItem else {
            return
        }

        combineLatest(self.viewModel.note,
                self.viewModel.date,
                self.viewModel.priority)
            .map { $0 != nil && $1 != nil && $2 != nil }
            .bindTo(saveButton.rEnabled)
    }

    // MARK: - Required init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
