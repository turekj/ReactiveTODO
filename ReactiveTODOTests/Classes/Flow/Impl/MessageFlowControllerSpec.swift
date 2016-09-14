@testable import ReactiveTODOFramework
import Nimble
import Quick
import Swinject


@available(iOS 10.0, *)
class MessageFlowControllerSpec: QuickSpec {
    
    override func spec() {
        describe("MessageFlowControllerSpec") {
            let activeConversationMock = MSConversationMock()
            let noteListViewControllerMock = TODONoteListViewInteractionMock()
            let messageViewController = MessagesViewControllerMock(
                    activeConversationMock: activeConversationMock,
                    noteListViewControllerMock: noteListViewControllerMock)
            let messageFactory = MessageFactoryMock()
            let sut = MessageFlowController(messageFactory: messageFactory)
            
            context("When TODO note is selected") {
                it("Should create a message") {
                    sut.startFlow(messageViewController)
                    noteListViewControllerMock.onSelectTODO?("n_g")
                    
                    expect(activeConversationMock.insertedMessage).toNot(beNil())
                    expect(activeConversationMock.insertedMessage).to(
                        be(messageFactory.returnedMessage))
                    expect(messageFactory.createdMessageGuid).to(equal("n_g"))
                }
            }
        }
    }
}
