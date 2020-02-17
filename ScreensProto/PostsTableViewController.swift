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

        observer = ModelEvents.PostDataNotification.observe{
            self.reloadData();
        }
        
        reloadData();
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
                print(self.teamName)
                print(self.data)
                self.tableView.reloadData();
                }
        }
      }
    
    override func viewWillAppear(_ animated: Bool) {
          print("viewWillAppear")
          
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
         Model.instance.getCurrentUserNameByID { (name) in
            cell.postFromLabel.text = name;
               }
        cell.postTitleLabel.text = p.title
        return cell

        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
