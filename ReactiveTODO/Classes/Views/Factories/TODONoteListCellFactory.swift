import UIKit


class TODONoteListCellFactory: TODONoteListCellFactoryProtocol {

    let bundle: NSBundle
    let dateFormatter: DateFormatterProtocol
    let priorityFormatter: PriorityImageNameFormatterProtocol

    init(bundle: NSBundle,
         dateFormatter: DateFormatterProtocol,
         priorityFormatter: PriorityImageNameFormatterProtocol) {
        self.bundle = bundle
        self.dateFormatter = dateFormatter
        self.priorityFormatter = priorityFormatter
    }

    func configureCell(cell: TODONoteListCell,
                       note: TODONote) -> TODONoteListCell {
        let imageName = self.priorityFormatter.format(note.priority)
        cell.dateView.text = self.dateFormatter.format(note.date)
        cell.priorityView.image = UIImage(named: imageName,
                inBundle: bundle, compatibleWithTraitCollection: nil)
        cell.titleView.text = note.note

        return cell
    }
}
