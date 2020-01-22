//
//  User + Firebase.swift
//  ScreensProto
//
//  Created by לידור משיח on 15/01/2020.
//  Copyright © 2020 לידור משיח. All rights reserved.
//

import Foundation
import Firebase

extension User {
    
    convenience init(json:[String:Any]) {
        self.nickName = json["nickName"] as! String
        self.fullName = json["fullName"] as! String
        self.email = json["email"] as! String
        self.password = json["password"] as! String
        self.validate = json["validate"] as! String
    }
    
    func toJson()-> [String:String]{
        var json = [String:String]()
        json["nickName"] = nickName
        json["fullName"] = fullName
        json["email"] = email
        json["password"] = password
        json["validate"] = validate
        return json
    }
}
