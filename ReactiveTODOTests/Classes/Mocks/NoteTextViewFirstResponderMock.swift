@testable import ReactiveTODO
import UIKit


class NoteTextViewFirstResponderMock: NoteTextView {

    var resignedFirstResponder = false

    override func resignFirstResponder() -> Bool {
        self.resignedFirstResponder = true

        return super.resignFirstResponder()
    }
}
