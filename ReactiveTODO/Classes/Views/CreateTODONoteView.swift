import Cartography
import UIKit


class CreateTODONoteView: UIView {

    let datePicker = UIDatePicker()

    init() {
        super.init(frame: CGRectZero)

        self.configureView()
    }

    func configureView() {
        self.configureDatePicker()
    }

    func configureDatePicker() {
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
