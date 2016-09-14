import Foundation
import Swinject
import UIKit


public class MessageAssembly: AssemblyType {
    
    public init() { }
    
    public func assemble(container: Container) {
        if #available(iOS 10.0, *) {
            container.register(MessageFactoryProtocol.self) { r in
                let todoNoteDAO = r.resolve(TODONoteDataAccessObjectProtocol.self)!
                let dateFormatter = r.resolve(DateFormatterProtocol.self, name: "relative")!
                let messageImageFactory = r.resolve(MessageImageFactoryProtocol.self)!
                
                return MessageFactory(todoNoteDAO: todoNoteDAO,
                                      dateFormatter: dateFormatter,
                                      messageImageFactory: messageImageFactory)
            }
            
            container.register(MessageFlowControllerProtocol.self) { r in
                let messageFactory = r.resolve(MessageFactoryProtocol.self)!
                
                return MessageFlowController(messageFactory: messageFactory)
            }
        }
        
        container.register(MessageImageFactoryProtocol.self) { r in
            let bundle = NSBundle(forClass: MessageAssembly.self)
            let priorityFormatter = r.resolve(PriorityImageNameFormatterProtocol.self)!
            
            return MessageImageFactory(bundle: bundle,
                                       priorityFormatter: priorityFormatter,
                                       outputImageSize: CGSizeMake(100, 100))
        }
    }
}
