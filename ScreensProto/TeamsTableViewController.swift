//
//  TeamsTableViewController.swift
//  ScreensProto
//
//  Created by לידור משיח on 20/01/2020.
//  Copyright © 2020 לידור משיח. All rights reserved.
//

import UIKit

class TeamsTableViewController: UITableViewController {
    var selectedCategories = [String]();
    var teamsData = [Team]();
    
    override func viewDidLoad(){
        super.viewDidLoad();
        Model.instance.getTeamsByTypes(types: selectedCategories) { (data:[Team]?) in
        if (data != nil) {
            self.teamsData = data!;
           self.tableView.reloadData();
        }
    }
}
    
   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.teamsData.count;
    }

    
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               let cell: TeamsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "teamsCell", for: indexPath) as! TeamsTableViewCell

               let team = teamsData[indexPath.row]
    cell.name.text = team.teamName;
               //cell.avatarImg.image = UIImage(named: "avatar")
               return cell
           }
    var selected:Team?
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if (segue.identifier == "TeamPostsSegue"){
               let vc:PostsTableViewController = segue.destination as! PostsTableViewController
            vc.teamName = selected!.teamName
           }
       }
       
       
      
       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           selected = teamsData[indexPath.row]
           performSegue(withIdentifier: "TeamPostsSegue", sender: self)
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

}
