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

        Model.instance.getCurrentUserNameByID { (name) in
            self.wellcomeLable.text = "Wellcome " + name!;
        }
        
        Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(changePage), userInfo: nil, repeats: false);
        
    }
    
    @objc func changePage(){
        //self.dismiss(animated: true, completion: nil);
        performSegue(withIdentifier: "wellcomeUserSegue", sender: self)
        
    }
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
