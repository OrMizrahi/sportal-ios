//
//  CategoriesTableViewController.swift
//  ScreensProto
//
//  Created by לידור משיח on 14/01/2020.
//  Copyright © 2020 לידור משיח. All rights reserved.
//

import UIKit
import FirebaseAuth

class CategoriesTableViewController: UITableViewController {
    
        var data = [CategoriesModel]()
        var selectedNames = [String]();
        override func viewDidLoad() {
            super.viewDidLoad()
            
            Model.instance.getAllCategories { (_data:[CategoriesModel]?) in
                   if (_data != nil) {
                       self.data = _data!;
                       self.tableView.reloadData();
                   }
               };
            // Uncomment the following line to preserve selection between presentations
            // self.clearsSelectionOnViewWillAppear = false

            // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
            // self.navigationItem.rightBarButtonItem = self.editButtonItem
            
            
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
            let cell:CategoriesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoriesTableViewCell

            let category = data[indexPath.row]
            cell.categoryNameLabel.text = category.name
            //cell.avatarImg.image = UIImage(named: "avatar")
            return cell
        }
    
    var selected:CategoriesModel?
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected=data[indexPath.row];
        selectedNames.append(selected!.name.lowercased());
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

        
        // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "categoriesSegue"){
            let vc:TeamsTableViewController = segue.destination as! TeamsTableViewController
            vc.selectedCategories = selectedNames;
            
        }
    }
}
