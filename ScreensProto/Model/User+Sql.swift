//
//  User+Sql.swift
//  ScreensProto
//
//  Created by לידור משיח on 15/01/2020.
//  Copyright © 2020 לידור משיח. All rights reserved.
//

import Foundation

extension User{
    
   static func createUsersTable(){
        var errorMsg: UnsafeMutablePointer<Int8>? = nil;
    let res = sqlite3_exec(ModelSql.instance.database, "CREATE TABLE IF NOT EXISTS USERS (FULLNAME TEXT,EMAIL TEXT PRIMARY KEY, PASSWORD TEXT, UID TEXT)",nil,nil, &errorMsg);
        if(res != 0){
            print("error in creating table");
            return;
        } else{
            print("table was created");
            return;
            }
    }
        
        func addUser(){
            var sqlite3_stmt: OpaquePointer? = nil;
            if(sqlite3_prepare_v2(ModelSql.instance.database,"INSERT OR REPLACE INTO USERS(FULLNAME, EMAIL, PASSWORD, UID) VALUES (?,?,?,?);",-1,&sqlite3_stmt,nil) == SQLITE_OK){
                
                let fullName = self.fullName.cString(using: .utf8);
                let email = self.email.cString(using: .utf8);
                let password = self.password.cString(using: .utf8);
                let uid = self.uid.cString(using: .utf8);
                
                sqlite3_bind_text(sqlite3_stmt,1,fullName,-1,nil);
                sqlite3_bind_text(sqlite3_stmt,2,email,-1,nil);
                sqlite3_bind_text(sqlite3_stmt,3,password,-1,nil);
                sqlite3_bind_text(sqlite3_stmt,4,uid,-1,nil);
                
                if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                    print("new row added succesfully");
                }
            }
        }
    
    
    
    
}
