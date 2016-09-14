import Foundation


class MessageImageFactory: MessageImageFactoryProtocol {
    
    let bundle: NSBundle
    let priorityFormatter: PriorityImageNameFormatterProtocol
    let outputImageSize: CGSize
    
    init(bundle: NSBundle, priorityFormatter: PriorityImageNameFormatterProtocol,
         outputImageSize: CGSize) {
        self.bundle = bundle
        self.priorityFormatter = priorityFormatter
        self.outputImageSize = outputImageSize
    }
    
    func createMessageImage(note: TODONote) -> UIImage {
        let priorityIcon = self.priorityIcon(note)
        UIGraphicsBeginImageContextWithOptions(self.outputImageSize, false, 0.0)
        
        let context = UIGraphicsGetCurrentContext()!
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextFillRect(context, CGRect(origin: CGPointMake(0, 0), size: self.outputImageSize))
        priorityIcon.drawInRect(self.priorityIconDrawRect(priorityIcon))
        let img = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return img
    }
    
    private func priorityIcon(note: TODONote) -> UIImage {
        let priorityIconName = self.priorityFormatter.format(note.priority)
        
        return UIImage(named: priorityIconName,
                       inBundle: self.bundle,
                       compatibleWithTraitCollection: nil)!
    }
    
    private func priorityIconDrawRect(priorityIcon: UIImage) -> CGRect {
        let x = (self.outputImageSize.width - priorityIcon.size.width) * 0.5
        let y = (self.outputImageSize.height - priorityIcon.size.height) * 0.5
        let width = priorityIcon.size.width
        let height = priorityIcon.size.height
        
        return CGRectMake(x, y, width, height)
    }
}
