

import Foundation
import Firebase

class Team {
    
    var teamName:String = "";
    var type:String = "";
    var lastUpdate:Int64?
    init(name:String,type:String) {
        self.teamName = name;
        self.type = type;
    }
    
    init(json:[String:Any]) {
        self.teamName = json["teamName"] as! String;
        self.type = json["type"] as! String;
        let ts = json["lastUpdate"] as! Timestamp
        lastUpdate = ts.seconds
    }
    
    func toJson()-> [String:Any]{
        var json = [String:Any]();
        json["teamName"] = teamName;
        json["type"] = type;
        json["lastUpdate"] = FieldValue.serverTimestamp()
        return json
    }
}
