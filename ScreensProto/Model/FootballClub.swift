//
//  FootballClub.swift
//  ScreensProto
//
//  Created by לידור משיח on 14/01/2020.
//  Copyright © 2020 לידור משיח. All rights reserved.
//

import Foundation

class Team {
    
    var teamName:String = "";
    var logo:String = "";
    var type:String = "";
    
    init(name:String,logo:String,type:String) {
        self.teamName = name;
        self.logo = logo;
        self.type = type;
    }
    
    init(json:[String:Any]) {
        self.teamName = json["teamName"] as! String;
        self.logo = json["logo"] as! String;
        self.type = json["type"] as! String;
    }
       
    func toJson()-> [String:String]{
        var json = [String:String]();
        json["teamName"] = teamName;
        json["logo"] = logo;
        json["type"] = type;
        
           return json
    }
}
