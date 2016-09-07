import UIKit


extension UIColor {

    class func validValueColor() -> UIColor {
        return UIColor(red: 0.0, green: 0.478431, blue: 1.0, alpha: 1.0)
    }

    class func invalidValueColor() -> UIColor {
        return UIColor.redColor()
    }
}
