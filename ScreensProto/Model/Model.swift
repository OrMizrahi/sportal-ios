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
//        self.addTeams(teams: [Team(name: "barca",logo: "",type: "basketball"),Team(name: "barca2",logo:"",type:"soccer"),Team(name:"barca3",logo:"",type:"soccer")]);
    }
    
    func addUser(user:User){
        modelFirebase.addUser(user: user);
        user.addUser();
    }
//   Initiliezd on the first time the app loaded
    func addTeams(teams:[Team]){
        for team in teams{
            modelFirebase.addTeam(team: team);
            team.addTeam();
        }
    }
    
    func getAllTeams(callback:@escaping ([Team]?)->Void){
        modelFirebase.getAllTeams(callback: callback);
    }
    
    func getTeamsByTypes(types: [String], callback:@escaping ([Team]?)->Void){
        modelFirebase.getTeamsByType(types: types, callback: callback);
    }
    
    func addCategories(categories:[CategoriesModel]){
        
        for currentCategory in categories {
            currentCategory.addCategory();
            modelFirebase.addCategory(category: currentCategory);
        }
    }
    
    func addPost(post:Post) {
        modelFirebase.addPost(post: post)
        ModelEvents.PostDataNotification.post()
    }
    
    func getAllCategories(callback:@escaping ([CategoriesModel]?)->Void){
        modelFirebase.getAllCategories(callback: callback);
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
        print(date)
        return date
    }
    
    func updatePost(post:Post){
        print("updating")
        print(post.postId)
          modelFirebase.updatePost(post: post)
          ModelEvents.PostDataNotification.post()
      }
    
    func deletePost(post:Post) {
        modelFirebase.deletePost(post: post)
        //ModelEvents.PostDataNotification.post()
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
