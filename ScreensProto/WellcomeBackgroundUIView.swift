//
//  WellcomeBackgroundUIView.swift
//  ScreensProto
//
//  Created by לידור משיח on 20/02/2020.
//  Copyright © 2020 Lidor Mashiah. All rights reserved.
//

import UIKit

class WellcomeBackgroundUIView: UIView {

    func addBackground() {
        

        let imageViewBackground = UIImageView(frame: UIScreen.main.bounds)
        imageViewBackground.image = UIImage(named: "wellcomePage.jpg")

        // you can change the content mode:
        imageViewBackground.contentMode = UIView.ContentMode.scaleAspectFill

        self.addSubview(imageViewBackground)
        self.sendSubviewToBack(imageViewBackground)
    }
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
