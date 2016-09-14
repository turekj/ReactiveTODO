import Foundation
import Messages


@available(iOSApplicationExtension 10.0, *)
public class MessageFactory: MessageFactoryProtocol {
    
    let bundle: NSBundle
    let todoNoteDAO: TODONoteDataAccessObjectProtocol
    let dateFormatter: DateFormatterProtocol
    let priorityFormatter: PriorityImageNameFormatterProtocol
    
    init(bundle: NSBundle, todoNoteDAO: TODONoteDataAccessObjectProtocol,
         dateFormatter: DateFormatterProtocol,
         priorityFormatter: PriorityImageNameFormatterProtocol) {
        self.bundle = bundle
        self.todoNoteDAO = todoNoteDAO
        self.dateFormatter = dateFormatter
        self.priorityFormatter = priorityFormatter
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
        
        let imageName = self.priorityFormatter.format(note.priority)
        layout.caption = note.note
        layout.subcaption = self.dateFormatter.format(note.date)
        layout.image = UIImage(named: imageName,
                               inBundle: self.bundle,
                               compatibleWithTraitCollection: nil)
        
        return layout
    }
}
