//
//  FootballClub+Sql.swift
//  ScreensProto
//
//  Created by לידור משיח on 15/01/2020.
//  Copyright © 2020 לידור משיח. All rights reserved.
//

import Foundation

extension Team{
    
    static func createTeamsTable(){
           var errorMsg: UnsafeMutablePointer<Int8>? = nil;
        let res = sqlite3_exec(ModelSql.instance.database, "CREATE TABLE IF NOT EXISTS SPORTCLUBS ( CLUBNAME TEXT PRIMARY KEY, TYPE TEXT)",nil,nil, &errorMsg);
           if(res != 0){
               //print("error in creating clubs table");
               return;
           } else{
               //print("clubs table was created");
               return;
               }
       }
       
       func addTeam(){
              var sqlite3_stmt: OpaquePointer? = nil;
              if(sqlite3_prepare_v2(ModelSql.instance.database,"INSERT OR REPLACE INTO SPORTCLUBS(CLUBNAME, TYPE) VALUES (?,?);",-1,&sqlite3_stmt,nil) == SQLITE_OK){
               // print("jakbfkshdkjf")
                let teamName = self.teamName.cString(using: .utf8);
                let type = self.type.cString(using: .utf8)
                 
                  sqlite3_bind_text(sqlite3_stmt,1,teamName,-1,nil);
                  sqlite3_bind_text(sqlite3_stmt,2,type,-1,nil);
                
                  if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                     // print("new row added succesfully in CLUBS");
                  }
              }
          }
    
    static func getTeamsByTypesFromDb(types: [String])->[Team]{
           var sqlite3_stmt: OpaquePointer? = nil
           var data = [Team]()
           if(sqlite3_prepare_v2(ModelSql.instance.database,"SELECT * from SPORTCLUBS;",-1,&sqlite3_stmt,nil) == SQLITE_OK){
               while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                   let teamName = String(cString:sqlite3_column_text(sqlite3_stmt,0)!)
                   let type = String(cString:sqlite3_column_text(sqlite3_stmt,1)!)
                   let team = Team(name:teamName,type: type);
                   data.append(team)
               }
           }
           sqlite3_finalize(sqlite3_stmt)
       var filteredTeams:[Team] = [Team]();
        for team in data {
            if(types.contains(team.type)){
                filteredTeams.append(team);
            }
        }
           return filteredTeams
       }
    
        static func getAllTeamsFromDb()->[Team]{
          var sqlite3_stmt: OpaquePointer? = nil
          var data = [Team]()
          if(sqlite3_prepare_v2(ModelSql.instance.database,"SELECT * from SPORTCLUBS;",-1,&sqlite3_stmt,nil) == SQLITE_OK){
              while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                  let teamName = String(cString:sqlite3_column_text(sqlite3_stmt,0)!)
                  let type = String(cString:sqlite3_column_text(sqlite3_stmt,1)!)
                  
                let team = Team(name: teamName, type: type)
                  data.append(team)
              }
          }
          sqlite3_finalize(sqlite3_stmt)
          return data
      }
      
       static func setLastUpdate(lastUpdated:Int64){
           return ModelSql.instance.setLastUpdate(name: "SPORTCLUBS", lastUpdated: lastUpdated);
       }

       static func getLastUpdateDate()->Int64{
           return ModelSql.instance.getLastUpdateDate(name: "SPORTCLUBS")
       }
    
}
