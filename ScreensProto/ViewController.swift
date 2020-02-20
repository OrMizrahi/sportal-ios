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
                self!.performSegue(withIdentifier: "logInSegue", sender: self)
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.passwordField.isSecureTextEntry = true;
        view.addBackground(imageName: "logInBackground.jpg")
    }
    @IBAction func backToLogIn(_ segue: UIStoryboardSegue) {}
}

