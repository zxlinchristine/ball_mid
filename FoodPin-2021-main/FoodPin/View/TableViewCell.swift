

import UIKit

//this class is associated to the prototype cell
class TableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView! {
        didSet { //set rounded corners
            thumbnailImageView.layer.cornerRadius = 20
            thumbnailImageView.clipsToBounds = true
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
