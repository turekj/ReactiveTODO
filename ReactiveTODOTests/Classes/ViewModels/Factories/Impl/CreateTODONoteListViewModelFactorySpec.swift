@testable import ReactiveTODO
import Nimble
import Quick


class CreateTODONoteListViewModelFactorySpec: QuickSpec {

    override func spec() {
        describe("CreateTODONoteListViewModelFactory") {
            let sut = CreateTODONoteListViewModelFactory()

            context("When creating view model") {
                let viewModel = sut.createViewModel()

                it("Should set date to nil") {
                    expect(viewModel.date.value).to(beNil())
                }

                it("Should set note to nil") {
                    expect(viewModel.note.value).to(beNil())
                }

                it("Should set priority to nil") {
                    expect(viewModel.priority.value).to(beNil())
                }
            }
        }
    }
}
