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
    @IBOutlet weak var postFromLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var postContentTextView: UITextView!
    @IBOutlet weak var postTitleTextView: UITextView!
    var teamName:String?

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func save(_ sender: Any) {
        let p = Post(t: self.postTitleTextView.text)
        p.date =  Model.instance.currentDate()
        p.content = self.postContentTextView.text
        p.teamName = self.teamName!
        p.postId = "id" + FirebaseStorage.getCurrentTimeStampWOMiliseconds(dateToConvert: NSDate()) + String(Int.random(in: 1..<99999999999));
        guard let selectedImage = selectedImage else {
        Model.instance.addPost(post: p)
        self.navigationController?.popViewController(animated: true);
        return;
    }
                           
            Model.instance.saveImage(image: selectedImage) { (url) in
                p.image = url;
                Model.instance.addPost(post: p);
                self.navigationController?.popViewController(animated: true);
                           }
              
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
