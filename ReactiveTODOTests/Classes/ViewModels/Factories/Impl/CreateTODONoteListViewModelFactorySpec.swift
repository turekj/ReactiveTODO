@testable import ReactiveTODO
import Nimble
import Quick


class CreateTODONoteListViewModelFactorySpec: QuickSpec {

    override func spec() {
        describe("CreateTODONoteListViewModelFactory") {
            let sut = CreateTODONoteListViewModelFactory()

            context("When creating view model") {
                let viewModel = sut.createViewModel()

                it("Should set formValid to false") {
                    expect(viewModel.formValid.value).to(beFalse())
                }
            }
        }
    }
}
