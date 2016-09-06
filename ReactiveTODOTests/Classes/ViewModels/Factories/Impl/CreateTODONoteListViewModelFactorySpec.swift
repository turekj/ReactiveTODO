@testable import ReactiveTODO
import Nimble
import Quick


class CreateTODONoteListViewModelFactorySpec: QuickSpec {

    override func spec() {
        describe("CreateTODONoteListViewModelFactory") {
            let dateResolver = DateResolverMock()
            let sut = CreateTODONoteListViewModelFactory(
                    dateResolver: dateResolver)

            context("When creating view model") {
                let viewModel = sut.createViewModel()

                it("Should set date to now") {
                    expect(viewModel.date.value).to(equal(
                            dateResolver.nowReturnValue))
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
