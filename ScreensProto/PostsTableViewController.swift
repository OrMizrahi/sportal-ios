//
//  PostsTableViewController.swift
//  ScreensProto
//
//  Created by לידור משיח on 13/02/2020.
//  Copyright © 2020 Lidor Mashiah. All rights reserved.
//

import UIKit

class PostsTableViewController: UITableViewController {

    var data = [Post]();
    var teamName:String = ""
    var observer:Any?;

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        observer = ModelEvents.PostDataNotification.observe{
            self.reloadData();
        }
        
        reloadData();
    }
    @objc func refresh(sender:Any){
        self.reloadData()
        self.refreshControl?.endRefreshing()
    }

    deinit{
          if let observer = observer{
              ModelEvents.removeObserver(observer: observer)
          }
      }
      
      func reloadData(){
        Model.instance.getAllPostsByTeamName(teamName: teamName) { (_data:[Post]?) in
            if (_data != nil) {
                self.data = _data!;
               // print(self.teamName)
               // print(self.data)
                self.tableView.reloadData();
                }
        }
      }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        //  print("viewWillAppear")
          
      }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableViewCell
        
        let p = data[indexPath.row]
        cell.postFromLabel.text = p.postCreator
        cell.postTitleLabel.text = p.title
        if(p.image != ""){
            cell.postImage.kf.setImage(with: URL(string: p.image))
        }else{
            cell.postImage.isHidden = true
        }
        return cell

        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if (segue.identifier == "PostInfoSegue"){
               let vc:PostInfoViewController = segue.destination as! PostInfoViewController
                vc.post = selected
           }
           else if (segue.identifier == "AddPostSegue"){
                let vc:NewPostViewController = segue.destination as! NewPostViewController
            vc.teamName = self.teamName
        }
       }
       
       var selected:Post?
       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           selected = data[indexPath.row]
           performSegue(withIdentifier: "PostInfoSegue", sender: self)
       }
    
}
