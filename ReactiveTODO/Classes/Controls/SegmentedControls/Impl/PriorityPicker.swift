import ReactiveKit
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

    // MARK: - Required init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
