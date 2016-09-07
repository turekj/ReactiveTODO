@testable import ReactiveTODO
import Nimble
import Quick


class TODONoteListCellFactorySpec: QuickSpec {

    override func spec() {
        describe("TODONoteListCellFactory") {
            let dateFormatter = DateFormatterMock()
            dateFormatter.formatReturnValue = "Formatted Date"
            let priorityFormatter = PriorityImageNameFormatterMock()
            priorityFormatter.formatReturnValue = "white_pixel"
            let bundle = NSBundle(
                    forClass: TODONoteListCellFactorySpec.self)
            let sut = TODONoteListCellFactory(
                    bundle: bundle,
                    dateFormatter: dateFormatter,
                    priorityFormatter: priorityFormatter)
            let note = TODONote()
            note.date = NSDate()
            note.guid = "todo_note_guid"
            note.note = "Sample note"
            note.priority = .Low

            it("Should return input cell") {
                let cell = TODONoteListCell(style: .Default,
                        reuseIdentifier: "ReuseID")

                let result = sut.configureCell(cell, note: note)

                expect(result).to(be(cell))
            }

            it("Should set formatted date in date view label's text") {
                let cell = TODONoteListCell(style: .Default,
                        reuseIdentifier: "ReuseID")

                let result = sut.configureCell(cell, note: note)

                expect(result.dateView.text).to(equal("Formatted Date"))
            }

            it("Should set image returned from priority formatter") {
                let cell = TODONoteListCell(style: .Default,
                        reuseIdentifier: "ReuseID")
                let image = UIImage(named: "white_pixel",
                        inBundle: bundle,
                        compatibleWithTraitCollection: nil)!
                let imageData = UIImagePNGRepresentation(image)

                let result = sut.configureCell(cell, note: note)

                expect(result.priorityView.image).toNot(beNil())
                expect(UIImagePNGRepresentation(result.priorityView.image!))
                    .to(equal(imageData))
            }

            it("Should set note label's text to note from model") {
                let cell = TODONoteListCell(style: .Default,
                        reuseIdentifier: "ReuseID")

                let result = sut.configureCell(cell, note: note)

                expect(result.titleView.text).to(equal("Sample note"))
            }
        }
    }
}
