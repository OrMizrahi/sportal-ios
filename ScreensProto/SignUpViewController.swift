//
//  SignUpViewController.swift
//  ScreensProto
//
//  Created by לידור משיח on 23/12/2019.
//  Copyright © 2019 לידור משיח. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    @IBOutlet weak var fullNameText: UITextField!
    
    
    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    @IBOutlet weak var validateText: UITextField!
    
    @IBOutlet weak var errorLable: UILabel!
    
    
    @IBAction func saveUser(_ sender: UIButton) {
        
        var user = User(fname: self.fullNameText.text!, email: self.emailText.text!, pass: self.passwordText.text!, valid: self.validateText.text!);
        
        if (!validateUser(user: user)){
            errorLable.text = "ERROR! INVALID INPUT ENTERED";
        }else{
            
            Auth.auth().createUser(withEmail: user.email, password: user.password) { (result, error) in
                if(error != nil){
                    self.errorLable.text = error?.localizedDescription;
                }else{
                    user.uid = (result?.user.uid)!;
              Model.instance.addUser(user: user);
              self.performSegue(withIdentifier:"backAfterRegister", sender: self);
                }
            }
        }
        
    }
    
    
    func validateUser(user: User) -> Bool {
        var toBeChecked = [String]();
        toBeChecked.append(user.fullName);
        toBeChecked.append(user.email);
        toBeChecked.append(user.password);
        toBeChecked.append(user.validate);
        
        for item in toBeChecked {
            if (item == ""){
                return false;
            }
        }
        if(user.password != user.validate){
            return false;
        }
        return true;
    }
}
    

