@testable import ReactiveTODOFramework
import Foundation
import Messages


@available(iOS 10.0, *)
class MessagesViewControllerMock: MessagesViewControllerProtocol {
    
    var noteListViewController: TODONoteListViewControllerProtocol?
    var activeConversation: MSConversation?
    
    init(activeConversationMock: MSConversationMock,
         noteListViewControllerMock: TODONoteListViewInteractionMock) {
        self.activeConversation = activeConversationMock
        self.noteListViewController = noteListViewControllerMock
    }
}
