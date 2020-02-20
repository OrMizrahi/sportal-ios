
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.teamsData.count;
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TeamsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "teamsCell", for: indexPath) as! TeamsTableViewCell
        
        let team = teamsData[indexPath.row]
        cell.name.text = team.teamName
        switch team.teamName {
        case "Los Angeles Lakers":
            cell.teamLogoImage.image = UIImage(named: "LALLOGO.png")
            break
        case "Miami Heat":
            cell.teamLogoImage.image = UIImage(named: "miamiHeatLogo.png")
            break
        case "Juventus":
            cell.teamLogoImage.image = UIImage(named: "juvLogo.png")
            break
        case "Hapoel Petah Tikva FC":
            cell.teamLogoImage.image = UIImage(named: "hptLogo.png")
            break
        case "Golden State Warriors":
            cell.teamLogoImage.image = UIImage(named: "gswLogo.png")
            break
        case "FC Barcelona":
            cell.teamLogoImage.image = UIImage(named: "fcbLogo.png")
            break
        case "Chicago Bulls":
            cell.teamLogoImage.image = UIImage(named: "cbLogo.png")
            break
        case "Boston Celtics":
            cell.teamLogoImage.image = UIImage(named: "bcLogo.png")
            break
        case "Bayern Munich":
            cell.teamLogoImage.image = UIImage(named: "bmLogo.png")
            break
        default: break
        }
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}
