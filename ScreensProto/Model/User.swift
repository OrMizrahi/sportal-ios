

import Foundation
import Firebase

class User{
    
    var fullName = ""
    var email = ""
    var password = ""
    var validate = ""
    var uid = ""
    var lastUpdate:Int64?
    
    init(fname:String,email:String,pass:String,valid:String){
        self.fullName = fname
        self.email = email
        self.password = pass
        self.validate = valid
    }
    
    init(json:[String:Any]) {
        self.fullName = json["fullName"] as! String
        self.email = json["email"] as! String
        self.password = json["password"] as! String
        self.validate = json["validate"] as! String
        self.uid = json["uid"] as! String
        let ts = json["lastUpdate"] as! Timestamp
        lastUpdate = ts.seconds
    }
    
    func toJson()-> [String:Any]{
        var json = [String:Any]()
        json["fullName"] = fullName
        json["email"] = email
        json["password"] = password
        json["validate"] = validate
        json["uid"] = uid
        json["lastUpdate"] = FieldValue.serverTimestamp()
        return json
    }
}
