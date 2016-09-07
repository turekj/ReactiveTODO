import Cartography
import UIKit


class CreateTODONoteView: UIView {

    let noteLabel: UILabel
    let noteTextView: NoteTextView
    let priorityLabel: UILabel
    let priorityPicker: PriorityPicker
    let dateLabel: UILabel
    let datePicker: PopupDatePicker

    init(noteLabel: UILabel, noteTextView: NoteTextView,
         priorityLabel: UILabel, priorityPicker: PriorityPicker,
         dateLabel: UILabel, datePicker: PopupDatePicker) {
        self.noteLabel = noteLabel
        self.noteTextView = noteTextView
        self.priorityLabel = priorityLabel
        self.priorityPicker = priorityPicker
        self.dateLabel = dateLabel
        self.datePicker = datePicker

        super.init(frame: CGRectZero)

        self.configureView()
    }

    func configureView() {
        self.configureNoteLabel()
        self.configureNoteTextView()
        self.configurePriorityLabel()
        self.configurePriorityPicker()
        self.configureDateLabel()
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
        self.priorityPicker.tintColor = UIColor.redColor()
        self.addSubview(self.priorityPicker)

        constrain(self.priorityPicker, self.priorityLabel) { p, l in
            p.height == 28
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

    func configureDatePicker() {
        self.addSubview(self.datePicker)

        constrain(self.datePicker, self.dateLabel) { p, l in
            p.leading == l.leading
            p.bottom == l.bottom + 38
            p.top == p.superview!.top + 10
            p.trailing == l.trailing
        }
    }

    // MARK: - Required init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
