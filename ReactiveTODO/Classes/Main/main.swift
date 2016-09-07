import UIKit

let isRunningTests = NSClassFromString("XCTestCase") != nil
let appDelegateClass: AnyClass =
    isRunningTests ? TestingAppDelegate.self : AppDelegate.self

UIApplicationMain(
        Process.argc,
        UnsafeMutablePointer<UnsafeMutablePointer<CChar>>(Process.unsafeArgv),
        nil,
        NSStringFromClass(appDelegateClass))
