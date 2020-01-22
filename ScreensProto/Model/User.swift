//
//  User.swift
//  ScreensProto
//
//  Created by לידור משיח on 06/01/2020.
//  Copyright © 2020 לידור משיח. All rights reserved.
//

import Foundation

class User{
    
    var fullName = ""
    var email = ""
    var password = ""
    var validate = ""
    var uid = ""
    
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
    }
    
    func toJson()-> [String:String]{
        var json = [String:String]()
        json["fullName"] = fullName
        json["email"] = email
        json["password"] = password
        json["validate"] = validate
        json["uid"] = uid
        return json
    }
}
