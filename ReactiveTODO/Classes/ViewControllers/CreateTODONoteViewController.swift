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
        self.bindNoteProperty()
        self.bindPriorityProperty()
        self.bindDateProperty()
        self.bindSaveButtonEnabled()
    }

    func bindNoteProperty() {
        self.createView.noteTextView.rText
            .filter { self.noteValidator.validate($0) }
            .bindTo(self.viewModel.note)
    }

    func bindPriorityProperty() {
        let priorityPicker = self.createView.priorityPicker

        priorityPicker.rSelectedSegmentIndex
            .filter { 0 <= $0 && $0 < priorityPicker.numberOfSegments }
            .map { (i: Int) -> Priority? in
                guard let t = priorityPicker.titleForSegmentAtIndex(i) else {
                    return nil
                }

                return Priority(rawValue: t)
            }.filter { self.priorityValidator.validate($0) }
            .bindTo(self.viewModel.priority)
    }

    func bindDateProperty() {
        self.createView.datePicker.rDate
            .filter { self.dateValidator.validate($0) }
            .bindTo(self.viewModel.date)
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
