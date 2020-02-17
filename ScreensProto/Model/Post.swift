//
//  Post.swift
//  ScreensProto
//
//  Created by לידור משיח on 13/02/2020.
//  Copyright © 2020 Lidor Mashiah. All rights reserved.
//

import Foundation

class Post {
    
    var title = ""
    var date = ""
    var image = ""
    var content = ""
    var teamName = ""
    var postId = ""
    var postCreator = ""
    
    init(t:String) {
        self.title = t
    }
    init(title:String,date:String,image:String,content:String,teamName:String,postId:String,creator:String){
        self.teamName = teamName
        self.title = title
        self.date = date
        self.image = image
        self.content = content
        self.postId = postId
        self.postCreator = creator;
    }
    
    init(json:[String:Any]) {
        self.title = json["title"] as! String
        self.date = json["date"] as! String
        self.image = json["image"] as! String
        self.content = json["content"] as! String
        self.teamName = json["teamName"] as! String
        self.postId = json["postId"] as! String
        self.postCreator = json["postCreator"] as! String
    }
    
    func toJson()-> [String:String]{
        var json = [String:String]()
        json["title"] = title
        json["date"] = date
        json["image"] = image
        json["content"] = content
        json["teamName"] = teamName
        json["postId"] = postId
        json["postCreator"] = postCreator
        return json
    }
    
}
