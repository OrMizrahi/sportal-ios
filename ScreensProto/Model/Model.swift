//
//  Model.swift
//  ScreensProto
//
//  Created by לידור משיח on 06/01/2020.
//  Copyright © 2020 לידור משיח. All rights reserved.
//

import Foundation

class Model {
    static let instance = Model();

    var modelFirebase:ModelFirebase = ModelFirebase();
    var modelSql:ModelSql = ModelSql.instance;
    
    private init(){
        modelSql.connect();
        
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
    
    func getAllCategories(callback:@escaping ([CategoriesModel]?)->Void){
        modelFirebase.getAllCategories(callback: callback);
    }
 
    func getCurrentUserNameByID(callback:@escaping (String?)->Void){
        return modelFirebase.getCurrentUserNameByID(callback: callback);
    }
    
}
