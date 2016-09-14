import Foundation


@available(iOSApplicationExtension 10.0, *)
class MessageFlowController: MessageFlowControllerProtocol {
    
    let messageFactory: MessageFactoryProtocol
    
    init(messageFactory: MessageFactoryProtocol) {
        self.messageFactory = messageFactory
    }
    
    func startFlow(messageController: MessagesViewControllerProtocol) {
        guard let list = messageController.noteListViewController
                         as? TODONoteListViewController else {
            return
        }
        
        messageController.noteListViewController?.onSelectTODO = { guid in
            let message = self.messageFactory.createMessage(guid)
            messageController.activeConversation?.insertMessage(message, completionHandler: nil)
        }
        
        list.notesView.addButton.hidden = true
    }
}
