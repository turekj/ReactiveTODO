import UIKit


extension CGColor: Equatable {}


public func ==(lhs: CGColor, rhs: CGColor) -> Bool {
    return CGColorEqualToColor(lhs, rhs)
}
