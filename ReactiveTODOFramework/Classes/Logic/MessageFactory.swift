import Foundation
import Messages


@available(iOSApplicationExtension 10.0, *)
public class MessageFactory: MessageFactoryProtocol {
    
    let todoNoteDAO: TODONoteDataAccessObjectProtocol
    let dateFormatter: DateFormatterProtocol
    let messageImageFactory: MessageImageFactoryProtocol
    
    init(todoNoteDAO: TODONoteDataAccessObjectProtocol,
         dateFormatter: DateFormatterProtocol,
         messageImageFactory: MessageImageFactoryProtocol) {
        self.todoNoteDAO = todoNoteDAO
        self.dateFormatter = dateFormatter
        self.messageImageFactory = messageImageFactory
    }
    
    public func createMessage(noteGUID: String) -> MSMessage {
        let message = MSMessage()
        let layout = MSMessageTemplateLayout()
        message.layout = self.configureLayout(layout, forNoteGuid: noteGUID)
        
        return message
    }
    
    private func configureLayout(layout: MSMessageTemplateLayout,
                                 forNoteGuid guid: String) -> MSMessageTemplateLayout {
        guard let note = self.todoNoteDAO.getNote(guid) else {
            return layout
        }
        
        layout.caption = note.note
        layout.subcaption = self.dateFormatter.format(note.date)
        layout.image = self.messageImageFactory.createMessageImage(note)
        
        return layout
    }
}
