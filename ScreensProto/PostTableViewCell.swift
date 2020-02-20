
import UIKit

class PostTableViewCell: UITableViewCell {

    

    @IBOutlet weak var postTitleLabel: UILabel!
    
    @IBOutlet weak var postFromLabel: UILabel!
    
    @IBOutlet weak var postImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
