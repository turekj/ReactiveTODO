import Cartography
import Messages
import ReactiveTODOFramework
import Swinject
import UIKit



class MessagesViewController: MSMessagesAppViewController {
    
    lazy var assembler: Assembler = self.createAssembler()
    var noteListViewController: TODONoteListViewController?
    
    private func createAssembler() -> Assembler {
        let assemblies = [GlobalAssembly(), TODOListAssembly()] as [AssemblyType]
        
        return try! Assembler(assemblies: assemblies)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureDatabase()
        self.addNoteListViewController()
    }
    
    private func configureDatabase() {
        let configurator = self.assembler.resolver.resolve(RealmConfigurationFactoryProtocol.self)!
        configurator.updateDefaultRealmConfiguration()
    }
    
    private func addNoteListViewController() {
        self.noteListViewController = self.assembler.resolver.resolve(
            TODONoteListViewController.self)!
        
        self.noteListViewController?.onSelectTODO = { guid in
            self.activeConversation?.insertText(guid, completionHandler: nil)
        }
        
        self.addChildController(self.noteListViewController!)
    }
    
    private func addChildController(controller: UIViewController) {
        self.addChildViewController(controller)
        self.view.addSubview(controller.view)
        controller.didMoveToParentViewController(self)
        
        constrain(controller.view) { v in
            v.edges == v.superview!.edges
        }
    }
    
    // MARK: - Conversation Handling
    
    override func willBecomeActiveWithConversation(conversation: MSConversation) {
        // Called when the extension is about to move from the inactive to active state.
        // This will happen when the extension is about to present UI.
        
        // Use this method to configure the extension and restore previously stored state.
    }
    
    override func didResignActiveWithConversation(conversation: MSConversation) {
        // Called when the extension is about to move from the active to inactive state.
        // This will happen when the user dissmises the extension, changes to a different
        // conversation or quits Messages.
        
        // Use this method to release shared resources, save user data, invalidate timers,
        // and store enough state information to restore your extension to its current state
        // in case it is terminated later.
    }
    
    override func didReceiveMessage(message: MSMessage, conversation: MSConversation) {
        // Called when a message arrives that was generated by another instance of this
        // extension on a remote device.
        
        // Use this method to trigger UI updates in response to the message.
    }
    
    override func didStartSendingMessage(message: MSMessage, conversation: MSConversation) {
        // Called when the user taps the send button.
    }
    
    override func didCancelSendingMessage(message: MSMessage, conversation: MSConversation) {
        // Called when the user deletes the message without sending it.
        
        // Use this to clean up state related to the deleted message.
    }
    
    override func willTransitionToPresentationStyle(presentationStyle: MSMessagesAppPresentationStyle) {
        // Called before the extension transitions to a new presentation style.
        
        // Use this method to prepare for the change in presentation style.
    }
    
    override func didTransitionToPresentationStyle(presentationStyle: MSMessagesAppPresentationStyle) {
        // Called after the extension transitions to a new presentation style.
        
        // Use this method to finalize any behaviors associated with the change in presentation style.
    }
    
}
