import Cartography
import UIKit


class TODONoteListView: UIView {

    let list = UITableView(frame: CGRectZero, style: .Plain)
    let addButton = AddTODOButton()

    init() {
        super.init(frame: CGRectZero)

        self.configureView()
    }

    func configureView() {
        self.configureList()
        self.configureAddButton()
    }

    func configureList() {
        self.addSubview(self.list)

        constrain(self.list) { v in
            v.edges == v.superview!.edges
        }
    }

    func configureAddButton() {
        self.addSubview(self.addButton)

        constrain(self.addButton) { b in
            b.width == 50
            b.height == 50
            b.trailing == b.superview!.trailing - 10
            b.bottom == b.superview!.bottom - 10
        }
    }

    // MARK: - Required init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
