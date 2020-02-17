//
//  NewPostViewController.swift
//  ScreensProto
//
//  Created by לידור משיח on 13/02/2020.
//  Copyright © 2020 Lidor Mashiah. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate  {
    
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postContentTextView: UITextView!
    @IBOutlet weak var postTitleTextView: UITextView!
    @IBOutlet weak var savingPostLabel: UILabel!
    @IBOutlet weak var savingPostSpiner: UIActivityIndicatorView!
    
    var teamName:String?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        savingPostSpiner.isHidden = true
        savingPostLabel.isHidden = true
    }
    
    @IBAction func save(_ sender: Any) {
        let p = Post(t: self.postTitleTextView.text)
        p.date =  Model.instance.currentDate()
        p.content = self.postContentTextView.text
        p.teamName = self.teamName!
        p.postId = "id" + FirebaseStorage.getCurrentTimeStampWOMiliseconds(dateToConvert: NSDate()) + String(Int.random(in: 1..<99999999999));
        Model.instance.getCurrentUserNameByID { (name) in
            p.postCreator = name!
            self.savingPostLabel.isHidden = false
            self.savingPostSpiner.isHidden = false
            guard let selectedImage = self.selectedImage else {
                Model.instance.addPost(post: p)
                self.navigationController?.popViewController(animated: true);
                return;
            }
            
            Model.instance.saveImage(image: selectedImage) { (url) in
                p.image = url;
                
                Model.instance.addPost(post: p);

               /* Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.changePage), userInfo: nil, repeats: false);*/
                self.navigationController?.popViewController(animated:true);
                }
            }
        }
    
        @objc func changePage(){
            self.navigationController?.popViewController(animated:true);
            }
    
    @IBAction func choosePhoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerController.SourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    
    var selectedImage:UIImage?
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage;
        self.postImage.image = selectedImage;
        dismiss(animated: true, completion: nil);
    }
}
