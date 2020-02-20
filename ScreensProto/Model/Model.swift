//
//  Model.swift
//  ScreensProto
//
//  Created by לידור משיח on 06/01/2020.
//  Copyright © 2020 לידור משיח. All rights reserved.
//

import Foundation
import UIKit

class Model {
    static let instance = Model();

    var modelFirebase:ModelFirebase = ModelFirebase();
    var modelSql:ModelSql = ModelSql.instance;
    
    private init(){
        modelSql.connect();
        currentDate()
        
    }
    
    func addUser(user:User){
        modelFirebase.addUser(user: user);
        user.addUser();
    }
//   Initiliezd on the first time the app loaded
    func addTeams(teams:[Team]){
        for team in teams{
            modelFirebase.addTeam(team: team);
            //team.addTeam()
        }
    }
    
    func getAllTeams(callback:@escaping ([Team]?)->Void){
        let lud = Team.getLastUpdateDate()
        
        modelFirebase.getAllTeams(since: lud) { (data) in
            var lud:Int64 = 0;
            for team in data! {
                team.addTeam()
                if team.lastUpdate! > lud { lud = team.lastUpdate! }
            }
            Team.setLastUpdate(lastUpdated: lud)
            let finalData = Team.getAllTeamsFromDb()
            callback(finalData)
        }
    }
    
    func getTeamsByTypes(types: [String], callback:@escaping ([Team]?)->Void){
          let lud = Team.getLastUpdateDate()
              modelFirebase.getTeamsByType(since: lud,types: types) { (data) in
                  var lud:Int64 = 0;
                  for team in data! {
                      team.addTeam()
                      if team.lastUpdate! > lud { lud = team.lastUpdate! }
                  }
                  Team.setLastUpdate(lastUpdated: lud)
                let finalData = Team.getTeamsByTypesFromDb(types:types)
                  callback(finalData)
              }
      
    }
    
    func addCategories(categories:[CategoriesModel]){
        
        for currentCategory in categories {
        //    currentCategory.addCategory();
            modelFirebase.addCategory(category: currentCategory);
        }
    }
    
    func addPost(post:Post) {
        modelFirebase.addPost(post: post)
        ModelEvents.PostDataNotification.post()
    }
    
    func getAllCategories(callback:@escaping ([CategoriesModel]?)->Void){
        let lud = CategoriesModel.getLastUpdateDate()
        
        modelFirebase.getAllCategories(since: lud) { (data) in
            var lud:Int64 = 0;
            for category in data! {
                category.addCategory()
                if category.lastUpdate! > lud { lud = category.lastUpdate! }
            }
            CategoriesModel.setLastUpdate(lastUpdated: lud)
            let finalData = CategoriesModel.getAllCategoriesFromDb()
            callback(finalData)
        }
    }
    func getAllPostsByTeamName(teamName:String,callback:@escaping ([Post]?)->Void){
       modelFirebase.getAllPostsByTeamName(teamName:teamName,callback: callback);
       }
 
    func getCurrentUserNameByID(callback:@escaping (String?)->Void){
        return modelFirebase.getCurrentUserNameByID(callback: callback);
    }
    
    func saveImage(image:UIImage, callback: @escaping (String)->Void){
           FirebaseStorage.saveImage(image: image, callback: callback)
       }
        
    func currentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let s = formatter.string(from: Date())
        let myDate = formatter.date(from: s)
        formatter.dateFormat = "dd-MM-yyyy"
        let date = formatter.string(from: myDate!)
        //print(date)
        return date
    }
    
    func updatePost(post:Post){
         //let lud = Post.getLastUpdateDate()
        
          modelFirebase.updatePost(post: post)
          Post.updatePostOnSql(post: post)
         // Post.setLastUpdate(lastUpdated: lud)
           ModelEvents.PostDataNotification.post()
      }
    
    func deletePost(post:Post) {
        // let lud = Post.getLastUpdateDate()
        modelFirebase.deletePost(post: post)
        Post.deletePostOnSql(post:post)
        //Post.setLastUpdate(lastUpdated: lud)
        ModelEvents.PostDataNotification.post()
    }
    
}

class ModelEvents{
    static let PostDataNotification = ModelEventsTemplate(name: "com.sportal.PostDataNotification");
    static let LoginStateNotification = ModelEventsTemplate(name: "com.sportal.LoginStateNotification");

    
    static func removeObserver(observer:Any){
        NotificationCenter.default.removeObserver(observer)
    }
    private init(){}
}

class ModelEventsTemplate{
    let notificationName:String;
    
    init(name:String){
        notificationName = name;
    }
    func observe(callback:@escaping ()->Void)->Any{
        return NotificationCenter.default.addObserver(forName: NSNotification.Name(notificationName),object: nil, queue: nil) { (data) in callback();
        }
    }
    
    func post(){
        NotificationCenter.default.post(name: NSNotification.Name(notificationName), object: self,userInfo:nil);
    }
    
  


}
