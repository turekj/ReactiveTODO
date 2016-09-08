import ReactiveKit
import UIKit


extension UITableView {
    var selectedRow: Stream<Int> {
        let selector = #selector(UITableViewDelegate.tableView(
            _:didSelectRowAtIndexPath:))

        return rDelegate.stream(selector) {
            (s: PushStream<Int>, _: UITableView, indexPath: NSIndexPath) in
                s.next(indexPath.row)
        }
    }
}
