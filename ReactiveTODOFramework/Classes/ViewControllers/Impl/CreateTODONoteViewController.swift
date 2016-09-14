import Cartography
import ReactiveKit
import ReactiveUIKit
import UIKit


public class CreateTODONoteViewController: UIViewController,
        CreateTODONoteViewControllerProtocol {

    let createView: CreateTODONoteView
    let viewModel: CreateTODONoteViewModel

    public var onSave: ((NSDate, String, Priority) -> Void)?

    init(view: CreateTODONoteView,
         viewModel: CreateTODONoteViewModel) {
        self.createView = view
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    // MARK: - Lifecycle

    public override func viewDidLoad() {
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
        self.onSave?(self.createView.datePicker.date.value!,
                self.createView.noteTextView.note.value!,
                self.createView.priorityPicker.priority.value!)
    }

    func configureView() {
        self.view.addSubview(self.createView)

        constrain(self.createView) { v in
            v.edges == v.superview!.edges
        }
    }

    func bindViewModel() {
        self.bindFormValidProperty()
        self.bindSaveButtonEnabled()
        self.bindNoteTextViewResignFirstResponderOnTap()
    }

    func bindFormValidProperty() {
        combineLatest(self.createView.datePicker.date,
                self.createView.noteTextView.note,
                self.createView.priorityPicker.priority)
            .map { d, n, p in d != nil && n != nil && p != nil }
            .bindTo(self.viewModel.formValid)
    }

    func bindSaveButtonEnabled() {
        guard let saveButton = self.navigationItem.rightBarButtonItem else {
            return
        }

        self.viewModel.formValid.bindTo(saveButton.rEnabled)
    }

    func bindNoteTextViewResignFirstResponderOnTap() {
        self.createView.tapStream
            .observeIn(ImmediateOnMainExecutionContext)
            .observeNext { _ in
                self.createView.noteTextView.resignFirstResponder()
            }.disposeIn(self.rBag)
    }

    // MARK: - Required init

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
