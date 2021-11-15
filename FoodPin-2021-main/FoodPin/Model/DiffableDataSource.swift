
import UIKit

enum Section {  //type of the table section
    case all  //one section only
}

class DiffableDataSource: UITableViewDiffableDataSource<Section, Ball> {
    //enable editable table cells
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}
