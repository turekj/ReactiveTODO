import Foundation
import Swinject
import UIKit


public class MessageAssembly: AssemblyType {
    
    public init() { }
    
    public func assemble(container: Container) {
        if #available(iOS 10.0, *) {
            container.register(MessageFactoryProtocol.self) { r in
                let bundle = NSBundle(forClass: MessageAssembly.self)
                let todoNoteDAO = r.resolve(TODONoteDataAccessObjectProtocol.self)!
                let dateFormatter = r.resolve(DateFormatterProtocol.self, name: "relative")!
                let priorityFormatter = r.resolve(PriorityImageNameFormatterProtocol.self)!
            
                return MessageFactory(bundle: bundle, todoNoteDAO: todoNoteDAO,
                                      dateFormatter: dateFormatter,
                                      priorityFormatter: priorityFormatter)
            }
        }
    }
}
