//
//  PostInfoViewController.swift
//  ScreensProto
//
//  Created by לידור משיח on 13/02/2020.
//  Copyright © 2020 Lidor Mashiah. All rights reserved.
//

import UIKit
import Kingfisher

class PostInfoViewController: UIViewController,UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    @IBOutlet weak var postFromLabel: UILabel!
    @IBOutlet weak var postDate: UILabel!
    @IBOutlet weak var postTitleTextView: UITextView!
    @IBOutlet weak var postContentTextView: UITextView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var editImageButton: UIButton!
    @IBOutlet weak var updatePostButton: UIButton!
    
    var post:Post?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Model.instance.getCurrentUserNameByID { (name) in
            self.postFromLabel.text = name
        }
        postDate.text = post?.date
        postTitleTextView.text = post?.title
        postContentTextView.text = post?.content
        if(post?.image != ""){
            postImage.kf.setImage(with: URL(string: post!.image))
        }
        postTitleTextView.isUserInteractionEnabled = false
        self.lock()
    }
    
    
    @IBAction func editPost(_ sender: Any) {
        postTitleTextView.isUserInteractionEnabled = true
        postContentTextView.isUserInteractionEnabled = true
        editImageButton.isHidden = false
        updatePostButton.isHidden = false
    }
    func lock(){
        postTitleTextView.isUserInteractionEnabled = false
        postContentTextView.isUserInteractionEnabled = false
        editImageButton.isHidden = true
        updatePostButton.isHidden = true
    }
    
    @IBAction func changePhoto(_ sender: Any) {
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
    
    
    @IBAction func update(_ sender: Any) {
          
        self.post!.content = self.postContentTextView.text
        self.post!.title = self.postTitleTextView.text
           guard let selectedImage = selectedImage else {
            Model.instance.updatePost(post: self.post!)
           self.navigationController?.popViewController(animated: true);
          return
       }
                              
        Model.instance.saveImage(image: selectedImage) { (url) in
            self.post?.image = url
            Model.instance.updatePost(post: self.post!)
            self.navigationController?.popViewController(animated: true)
        }
        

       
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
