import UIKit


class AddTODOButton: UIButton {

    init() {
        super.init(frame: CGRectZero)

        self.configureButton()
    }

    func configureButton() {
        self.configureBackground()
        self.configureCornerRadius()
        self.configureShadow()
        self.configureTitle()
    }

    func configureBackground() {
        self.backgroundColor = UIColor.blueColor()
    }

    func configureCornerRadius() {
        self.layer.cornerRadius = 25.0
    }

    func configureShadow() {
        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4.0
        self.layer.shadowOffset = CGSizeMake(4.0, 4.0)
    }

    func configureTitle() {
        self.setTitle("+", forState: .Normal)
        self.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.titleLabel?.font = UIFont.boldSystemFontOfSize(20.0)
    }

    // MARK: - Required init

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
