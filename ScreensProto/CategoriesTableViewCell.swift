
import UIKit

class CategoriesTableViewCell: UITableViewCell {

    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
