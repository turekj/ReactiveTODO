import ReactiveKit
import ReactiveUIKit
import UIKit


class PriorityPicker: UISegmentedControl, PriorityPickerProtocol {

    let validator: Validator<Priority?>
    let priority: Property<Priority?>

    init(validator: Validator<Priority?>,
         priorities: [Priority]) {
        self.validator = validator
        self.priority = Property(nil)

        super.init(frame: CGRectZero)

        self.initializeSegments(priorities)
        self.bindViewModel()
    }

    private func initializeSegments(priorities: [Priority]) {
        let rawPriorities = priorities.map { (p: Priority) -> String in
            p.rawValue
        }

        for (index, priority) in rawPriorities.enumerate() {
            self.insertSegmentWithTitle(priority, atIndex: index,
                    animated: false)
        }
    }

    func bindViewModel() {
        self.bindPriorityProperty()
        self.bindNoteValidityStyle()
    }

    func bindPriorityProperty() {
        self.rSelectedSegmentIndex.filter { index in
            0 <= index && index < self.numberOfSegments
        }.map { (index: Int) -> Priority? in
            guard let title = self.titleForSegmentAtIndex(index) else {
                return nil
            }

            let priority = Priority(rawValue: title)

            if (self.validator.validate(priority)) {
                return priority
            }
            else {
                return nil
            }
        }.bindTo(self.priority)
    }

    func bindNoteValidityStyle() {
        self.priority.map {
            $0 != nil ? UIColor.validValueColor() : UIColor.invalidValueColor()
        }.observeIn(ImmediateOnMainExecutionContext)
         .observeNext { color in
            self.tintColor = color
            self.layer.borderColor = color.CGColor
        }.disposeIn(self.rBag)
    }

    // MARK: - Required init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
