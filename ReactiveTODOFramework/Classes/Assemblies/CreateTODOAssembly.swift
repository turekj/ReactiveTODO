import Foundation
import Swinject
import UIKit


public class CreateTODOAssembly: AssemblyType {

    public init() { }
    
    public func assemble(container: Container) {
        container.register(CreateTODONoteViewController.self) { r in
            let view = r.resolve(CreateTODONoteView.self)!
            let viewModel = r.resolve(CreateTODONoteViewModel.self)!

            return CreateTODONoteViewController(view: view,
                    viewModel: viewModel)
        }

        container.register(CreateTODONoteView.self) { r in
            let noteTextView = r.resolve(NoteTextView.self)!
            let priorityPicker = r.resolve(PriorityPicker.self)!
            let datePicker = r.resolve(PopupDatePicker.self)!

            return CreateTODONoteView(noteLabel: UILabel(),
                    noteTextView: noteTextView,
                    priorityLabel: UILabel(),
                    priorityPicker: priorityPicker,
                    dateLabel: UILabel(),
                    datePicker: datePicker)
        }

        container.register(NoteTextView.self) { r in
            let noteValidator = r.resolve(Validator<String?>.self)!

            return NoteTextView(validator: noteValidator)
        }

        container.register(PriorityPicker.self) { r in
            let priorityValidator = r.resolve(Validator<Priority?>.self)!
            let priorities = [Priority.Urgent, Priority.High,
                              Priority.Medium, Priority.Low]

            return PriorityPicker(validator: priorityValidator,
                    priorities: priorities)
        }

        container.register(PopupDatePicker.self) { r in
            let validator = r.resolve(Validator<NSDate?>.self)!
            let dateFormatter = r.resolve(DateFormatterProtocol.self,
                    name: "relative")!

            return PopupDatePicker(validator: validator,
                    dateFormatter: dateFormatter,
                    datePicker: UIDatePicker(),
                    triggerPickerButton: UIButton(type: .RoundedRect))
        }

        container.register(CreateTODONoteViewModel.self) { r in
            let factory = r.resolve(
                    CreateTODONoteListViewModelFactoryProtocol.self)!

            return factory.createViewModel()
        }

        container.register(CreateTODONoteListViewModelFactoryProtocol.self) {
                _ in
            return CreateTODONoteListViewModelFactory()
        }
    }
}
