import Foundation
import Messages


@available(iOSApplicationExtension 10.0, *)
public protocol MessagesViewControllerProtocol: class {
    
    var noteListViewController: TODONoteListViewControllerProtocol? { get set }
    var activeConversation: MSConversation? { get }
}
