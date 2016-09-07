import Foundation
import Swinject


class CreateTODOAssembly: AssemblyType {

    func assemble(container: Container) {
        container.register(CreateTODONoteViewController.self) { r in
            let view = r.resolve(CreateTODONoteView.self)!
            let viewModel = r.resolve(CreateTODONoteViewModel.self)!
            let dateValidator = r.resolve(Validator<NSDate?>.self)!
            let noteValidator = r.resolve(Validator<String?>.self)!
            let priorityValidator = r.resolve(Validator<Priority?>.self)!

            return CreateTODONoteViewController(view: view,
                    viewModel: viewModel,
                    dateValidator: dateValidator,
                    noteValidator: noteValidator,
                    priorityValidator: priorityValidator)
        }

        container.register(CreateTODONoteView.self) { r in
            let noteTextView = r.resolve(NoteTextView.self)!
            let priorityPicker = r.resolve(PriorityPicker.self)!

            return CreateTODONoteView(noteLabel: UILabel(),
                    noteTextView: noteTextView,
                    priorityLabel: UILabel(),
                    priorityPicker: priorityPicker,
                    dateLabel: UILabel(),
                    triggerPickerButton: UIButton(type: .RoundedRect),
                    datePicker: UIDatePicker())
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
