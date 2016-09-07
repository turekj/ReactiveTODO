import Cartography
import ReactiveKit
import ReactiveUIKit
import UIKit


class PopupDatePicker: UIView, PopupDatePickerProtocol {

    let date: ReactiveKit.Property<NSDate?>

    let validator: Validator<NSDate?>
    let dateFormatter: DateFormatterProtocol
    let datePicker: UIDatePicker
    let triggerPickerButton: UIButton

    init(validator: Validator<NSDate?>,
         dateFormatter: DateFormatterProtocol,
         datePicker: UIDatePicker,
         triggerPickerButton: UIButton) {
        self.date = ReactiveKit.Property(nil)
        self.validator = validator
        self.dateFormatter = dateFormatter
        self.datePicker = datePicker
        self.triggerPickerButton = triggerPickerButton

        super.init(frame: CGRectZero)

        self.configureView()
        self.bindViewModel()
    }

    func configureView() {
        self.configureTriggerPickerButton()
        self.configureDatePicker()
    }

    func configureTriggerPickerButton() {
        self.triggerPickerButton.titleEdgeInsets =
                UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)
        self.triggerPickerButton.layer.borderWidth = 1.0
        self.triggerPickerButton.layer.cornerRadius = 5.0
        self.addSubview(self.triggerPickerButton)

        constrain(self.triggerPickerButton) { b in
            b.width == 200
            b.height == 28
            b.bottom == b.superview!.bottom
            b.leading == b.superview!.leading
        }
    }

    func configureDatePicker() {
        self.datePicker.backgroundColor = UIColor.whiteColor()
        self.datePicker.datePickerMode = .DateAndTime
        self.datePicker.hidden = true
        self.addSubview(self.datePicker)

        constrain(self.datePicker, self.triggerPickerButton) { p, b in
            p.top == p.superview!.top
            p.leading == p.superview!.leading
            p.trailing == p.superview!.trailing
            p.bottom == b.top - 10
        }
    }

    func bindViewModel() {
        self.bindDateProperty()
        self.bindDatePickerVisibility()
        self.bindButtonCaption()
        self.bindButtonValidityStyle()
    }

    func bindDateProperty() {
        self.datePicker.rDate.map { (date: NSDate) -> NSDate? in
            if (self.validator.validate(date)) {
                return date
            }
            else {
                return nil
            }
        }.bindTo(self.date)
    }

    func bindDatePickerVisibility() {
        self.triggerPickerButton.rTap
            .observeIn(ImmediateOnMainExecutionContext)
            .observeNext { _ in
                self.datePicker.hidden = !self.datePicker.hidden
            }.disposeIn(self.rBag)
    }

    func bindButtonCaption() {
        self.date.map { (date: NSDate?) -> String in
            guard let date = date else {
                return "Select future date"
            }

            return self.dateFormatter.format(date)
        }.bindTo(self.triggerPickerButton.rTitle)
    }

    func bindButtonValidityStyle() {
        self.date.map {
            $0 != nil ? UIColor.validValueColor() : UIColor.invalidValueColor()
        }.observeIn(ImmediateOnMainExecutionContext)
        .observeNext { color in
            self.triggerPickerButton.layer.borderColor = color.CGColor
            self.triggerPickerButton.setTitleColor(color, forState: .Normal)
        }.disposeIn(self.rBag)
    }

    // MARK: - Touch handling

    override func pointInside(point: CGPoint,
                              withEvent event: UIEvent?) -> Bool {
        for subview in self.subviews {
            guard !subview.hidden else {
                continue
            }

            let point = self.convertPoint(point, toView: subview)
            if (subview.pointInside(point, withEvent: event)) {
                return true
            }
        }

        return false
    }

    // MARK: - Required init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
