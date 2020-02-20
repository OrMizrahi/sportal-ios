//
//  Post.swift
//  ScreensProto
//
//  Created by לידור משיח on 13/02/2020.
//  Copyright © 2020 Lidor Mashiah. All rights reserved.
//

import Foundation
import Firebase

class Post {
    
    var title = ""
    var date = ""
    var image = ""
    var content = ""
    var teamName = ""
    var postId = ""
    var postCreator = ""
    //var lastUpdate:Int64?
    
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
    
  convenience init(json:[String:Any]) {
        let title = json["title"] as! String
        let date = json["date"] as! String
        let image = json["image"] as! String
        let content = json["content"] as! String
        let teamName = json["teamName"] as! String
        let postId = json["postId"] as! String
        let postCreator = json["postCreator"] as! String
        self.init(title:title,date:date,image:image,content:content,teamName:teamName,postId:postId,creator:postCreator)
        //let ts = json["lastUpdate"] as! Timestamp
       // lastUpdate = ts.seconds
    }
    
    func toJson()-> [String:Any]{
        var json = [String:Any]()
        json["title"] = title
        json["date"] = date
        json["image"] = image
        json["content"] = content
        json["teamName"] = teamName
        json["postId"] = postId
        json["postCreator"] = postCreator
       // json["lastUpdate"] = FieldValue.serverTimestamp()
        return json
    }
    
}
