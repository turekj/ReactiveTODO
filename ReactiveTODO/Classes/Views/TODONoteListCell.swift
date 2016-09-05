import Cartography
import UIKit


class TODONoteListCell: UITableViewCell {

    let priorityView = UIImageView()
    let titleView = UILabel()
    let dateView = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.configureCell()
    }

    func configureCell() {
        self.configurePriorityView()
        self.configureDateView()
        self.configureTitleView()
    }

    func configurePriorityView() {
        self.contentView.addSubview(self.priorityView)

        constrain(self.priorityView) { v in
            v.leading == v.superview!.leading
            v.centerY == v.superview!.centerY
            v.width == 16
            v.height == 16
        }
    }

    func configureDateView() {
        self.dateView.lineBreakMode = .ByTruncatingMiddle
        self.dateView.numberOfLines = 1
        self.dateView.textAlignment = .Center
        self.contentView.addSubview(self.dateView)

        constrain(self.dateView) { v in
            v.trailing == v.superview!.trailing - 10
            v.centerY == v.superview!.centerY
            v.width == v.superview!.width * 0.2
        }
    }

    func configureTitleView() {
        self.titleView.lineBreakMode = .ByTruncatingTail
        self.titleView.numberOfLines = 1
        self.titleView.textAlignment = .Left
        self.contentView.addSubview(self.titleView)

        constrain(self.titleView, self.dateView, self.priorityView) {
                tv, dv, pv in
            tv.leading == pv.trailing + 10
            tv.trailing == dv.leading - 10
            tv.centerY == tv.superview!.centerY
        }
    }

    // MARK: - Required init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
