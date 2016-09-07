import Foundation
import ReactiveKit
import ReactiveUIKit


class NoteTextView: UITextView, NoteTextViewProtocol {

    let validator: Validator<String?>
    let note: Property<String?>

    init(validator: Validator<String?>) {
        self.validator = validator
        self.note = Property(nil)

        super.init(frame: CGRectZero, textContainer: nil)

        self.configureView()
        self.bindViewModel()
    }

    func configureView() {
        self.autocorrectionType = .No
        self.layer.borderColor = self.tintColor.CGColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 5.0
        self.returnKeyType = .Done
    }

    func bindViewModel() {
        self.bindNoteProperty()
        self.bindNoteValidityStyle()
    }

    func bindNoteProperty() {
        self.rText.map { (text: String?) -> String? in
            if (self.validator.validate(text)) {
                return text
            }
            else {
                return nil
            }
        }.bindTo(self.note)
    }

    func bindNoteValidityStyle() {
        self.note.map {
            $0 != nil ? UIColor.validValueColor() : UIColor.invalidValueColor()
        }.observeIn(ImmediateOnMainExecutionContext)
         .observeNext { color in
            self.layer.borderColor = color.CGColor
        }.disposeIn(self.rBag)
    }

    // MARK: - Required init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
