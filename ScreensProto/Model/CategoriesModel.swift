

import Foundation
import Firebase

class CategoriesModel {
    var name: String = "";
    var lastUpdate:Int64?
    
    init(name: String) {
        self.name = name;
    }
    
    convenience init(json:[String:Any]) {
        let name = json["name"] as! String;
        self.init(name:name)
        let ts = json["lastUpdate"] as! Timestamp
        lastUpdate = ts.seconds
    }
    
    func toJson() -> [String:Any] {
        var json = [String:Any]();
        json["name"] = name;
        json["lastUpdate"] = FieldValue.serverTimestamp()
        return json;
    }
    
}
