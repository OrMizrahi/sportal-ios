//
//  TeamsViewCell.swift
//  ScreensProto
//
//  Created by לידור משיח on 14/01/2020.
//  Copyright © 2020 לידור משיח. All rights reserved.
//

import UIKit

class TeamsViewCell: UITableViewCell {

    @IBOutlet weak var clubNameLabel: UILabel!
    
    @IBOutlet weak var logoImage: UIImageView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
