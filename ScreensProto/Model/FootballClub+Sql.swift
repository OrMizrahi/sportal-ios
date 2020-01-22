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
        let res = sqlite3_exec(ModelSql.instance.database, "CREATE TABLE IF NOT EXISTS TEAMS ( TEAMNAME TEXT PRIMARY KEY, LOGO TEXT, TYPE TEXT)",nil,nil, &errorMsg);
           if(res != 0){
               print("error in creating table");
               return;
           } else{
               print("table was created");
               return;
               }
       }
       
       func addTeam(){
              var sqlite3_stmt: OpaquePointer? = nil;
              if(sqlite3_prepare_v2(ModelSql.instance.database,"INSERT OR REPLACE INTO CLUBS(TEAMNAME, LOGO, TYPE) VALUES (?,?,?);",-1,&sqlite3_stmt,nil) == SQLITE_OK){
               let teamName = self.teamName.cString(using: .utf8);
               let logo = self.logo.cString(using: .utf8);
                let type = self.type.cString(using: .utf8)
                 
                  
                  sqlite3_bind_text(sqlite3_stmt,1,teamName,-1,nil);
                  sqlite3_bind_text(sqlite3_stmt,2,logo,-1,nil);
                        
                sqlite3_bind_text(sqlite3_stmt,3,type,-1,nil);
                
                        
                    
                  if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                      print("new row added succesfully");
                  }
              }
          }
    
}
