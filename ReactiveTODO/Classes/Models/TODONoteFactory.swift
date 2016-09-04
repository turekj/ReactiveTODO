import Foundation


protocol TODONoteFactoryProtocol {
    
    func createTODONote() -> TODONote
}


class TODONoteFactory: TODONoteFactoryProtocol {

    let dateResolver: DateResolverProtocol
    let guidGenerator: GUIDGeneratorProtocol
    
    init(dateResolver: DateResolverProtocol,
         guidGenerator: GUIDGeneratorProtocol) {
        self.dateResolver = dateResolver
        self.guidGenerator = guidGenerator
    }
    
    func createTODONote() -> TODONote {
        let note = TODONote()
        note.date = self.dateResolver.now()
        note.guid = self.guidGenerator.generateGUID()
        note.priority = Priority.Low
        
        return note
    }
}
