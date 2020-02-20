
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
    }
    
    override func viewWillAppear(_ animated: Bool) {}
    
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
        switch category.name {
        case "Soccer":
            cell.categoryImage.image = UIImage(named: "ball.jpeg")
            break
        case "basketball":
            cell.categoryImage.image = UIImage(named: "Basketball.jpg")
            break
        default: break
            
        }
        return cell
    }
    
    var selected:CategoriesModel?
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selected=data[indexPath.row];
        selectedNames.append(selected!.name.lowercased());
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBAction func nextToTeamsButton(_ sender: Any) {
        if(selectedNames.capacity>0){
            performSegue(withIdentifier: "categoriesSegue", sender: self)
        }else{
            return;
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "categoriesSegue"){
            let vc:TeamsTableViewController = segue.destination as! TeamsTableViewController
            vc.selectedCategories = selectedNames;
            selectedNames = [String]();
        }
    }
}
