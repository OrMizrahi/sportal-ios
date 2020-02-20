//
//  WellcomeUserViewController.swift
//  ScreensProto
//
//  Created by לידור משיח on 22/01/2020.
//  Copyright © 2020 לידור משיח. All rights reserved.
//

import UIKit

class WellcomeUserViewController: UIViewController {


    @IBOutlet weak var wellcomeLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addBackground(contentMode: .scaleAspectFit)
        
        Model.instance.getCurrentUserNameByID { (name) in
            self.wellcomeLable.text = "Wellcome " + name!;
        }
        
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(changePage), userInfo: nil, repeats: false);
        
    }
    
    @objc func changePage(){
        performSegue(withIdentifier: "wellcomeUserSegue", sender: self)
        
    }

}
