//
//  CategoriesModel.swift
//  ScreensProto
//
//  Created by לידור משיח on 14/01/2020.
//  Copyright © 2020 לידור משיח. All rights reserved.
//

import Foundation

class CategoriesModel {
    var name: String = "";
    
    init(name: String) {
        self.name = name;
    }
    
    init(json:[String:Any]) {
        self.name = json["name"] as! String;
    }
    
    func toJson() -> [String:String] {
        var json = [String:String]();
        json["name"] = name;
        return json;
    }
    
}
