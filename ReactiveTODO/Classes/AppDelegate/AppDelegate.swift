import ReactiveTODOFramework
import Swinject
import UIKit


class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var assembler: Assembler = self.createAssembler()
    lazy var flowController: FlowControllerProtocol =
        self.createFlowController()

    private func createAssembler() -> Assembler {
        let assemblies = [CreateTODOAssembly(), FlowAssembly(),
                          GlobalAssembly(),
                          TODOListAssembly()] as [AssemblyType]

        return try! Assembler(assemblies: assemblies)
    }

    private func createFlowController() -> FlowControllerProtocol {
        return self.assembler.resolver.resolve(FlowControllerProtocol.self)!
    }

    // MARK: - Did finish launching

    func application(application: UIApplication, didFinishLaunchingWithOptions
            launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.initializeKeyWindow()
        self.startApplicationFlow()

        return true
    }

    func initializeKeyWindow() {
        self.window = self.createKeyWindow()
        self.window?.rootViewController = self.flowController.rootController
    }

    private func createKeyWindow() -> UIWindow {
        let bounds = UIScreen.mainScreen().bounds
        let window = UIWindow(frame: bounds)
        window.backgroundColor = UIColor.whiteColor()
        window.makeKeyAndVisible()

        return window
    }

    func startApplicationFlow() {
        self.flowController.navigateTo(TODONoteListViewController.self,
                animated: true)
    }
}
