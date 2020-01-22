//
//  ViewController.swift
//  ScreensProto
//
//  Created by לידור משיח on 23/12/2019.
//  Copyright © 2019 לידור משיח. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var errorLable: UILabel!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!

    var iconClick = true;
    @IBAction func showPassword(_ sender: UIButton) {
        
        if(iconClick == true){
            self.passwordField.isSecureTextEntry = false;
        }else {
            self.passwordField.isSecureTextEntry = true;
        }
        iconClick = !iconClick;
    }
    
    
    @IBAction func logInAction(_ sender: Any) {
        Auth.auth().signIn(withEmail: self.emailField.text!,password: self.passwordField.text!) { [weak self] authResult, error in
            guard self != nil else { return }
            if(error != nil){
                self?.errorLable.text = error?.localizedDescription;
                return;
            }else{
          //      Model.instance.getCurrentUserNameByID();
              self!.performSegue(withIdentifier: "logInSegue", sender: self)
                

            }
            
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordField.isSecureTextEntry = true;
    }
    

    @IBAction func saveDetailsAndBack(_ segue: UIStoryboardSegue) {
        
    }
    

}

