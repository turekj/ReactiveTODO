import Cartography
import UIKit


class CreateTODONoteView: UIView {

    let noteLabel = UILabel()
    let noteTextView = UITextView()
    let priorityLabel = UILabel()
    let priorityPicker = UISegmentedControl(items: [])
    let dateLabel = UILabel()
    let triggerDatePickerButton = UIButton(type: .Custom)
    let datePicker = UIDatePicker()

    init() {
        super.init(frame: CGRectZero)

        self.configureView()
    }

    func configureView() {
        self.configureNoteLabel()
        self.configureNoteTextView()
        self.configurePriorityLabel()
        self.configurePriorityPicker()
        self.configureDateLabel()
        self.configureTriggerDatePickerButton()
        self.configureDatePicker()
    }

    func configureNoteLabel() {
        self.noteLabel.text = "Note"
        self.addSubview(self.noteLabel)

        constrain(self.noteLabel) { l in
            l.height == 40
            l.top == l.superview!.top + 10
            l.leading == l.superview!.leading + 10
            l.trailing == l.superview!.trailing - 10
        }
    }

    func configureNoteTextView() {
        self.noteTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.noteTextView.layer.borderWidth = 1.0
        self.noteTextView.layer.cornerRadius = 2.0
        self.noteTextView.returnKeyType = .Done
        self.addSubview(self.noteTextView)

        constrain(self.noteTextView, self.noteLabel) { v, l in
            v.height == 120
            v.top == l.bottom + 10
            v.leading == l.leading
            v.trailing == l.trailing
        }
    }

    func configurePriorityLabel() {
        self.priorityLabel.text = "Priority"
        self.addSubview(self.priorityLabel)

        constrain(self.priorityLabel, self.noteLabel, self.noteTextView) {
                l1, l2, v in
            l1.height == l2.height
            l1.width == l2.width
            l1.leading == l2.leading
            l1.top == v.bottom + 10
        }
    }

    func configurePriorityPicker() {
        self.addSubview(self.priorityPicker)

        constrain(self.priorityPicker, self.priorityLabel) { p, l in
            p.height == 50
            p.top == l.bottom + 10
            p.leading == l.leading
            p.trailing == l.trailing
        }
    }

    func configureDateLabel() {
        self.dateLabel.text = "Date"
        self.addSubview(self.dateLabel)

        constrain(self.dateLabel, self.priorityLabel, self.priorityPicker) {
                l1, l2, p in
            l1.height == l2.height
            l1.width == l2.width
            l1.leading == l2.leading
            l1.top == p.bottom + 10
        }
    }

    func configureTriggerDatePickerButton() {
        self.triggerDatePickerButton.setTitle("Select date", forState: .Normal)
        self.addSubview(self.triggerDatePickerButton)

        constrain(self.triggerDatePickerButton, self.dateLabel) { b, l in
            b.width == 150
            b.height == 50
            b.leading == l.leading
            b.top == l.bottom + 10
        }
    }

    func configureDatePicker() {
        self.datePicker.hidden = true
        self.datePicker.datePickerMode = .DateAndTime
        self.addSubview(self.datePicker)

        constrain(self.datePicker) { p in
            p.edges == p.superview!.edges
        }
    }

    // MARK: - Required init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
