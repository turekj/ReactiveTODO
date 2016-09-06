import UIKit


class PriorityPicker: UISegmentedControl {

    init() {
        let priorities = [Priority.Urgent, Priority.High,
                          Priority.Medium, Priority.Low]

        super.init(items: priorities.map { $0.rawValue } as [String])
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    // MARK: - Required init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
