//
//  ModelSql.swift
//  ScreensProto
//
//  Created by לידור משיח on 14/01/2020.
//  Copyright © 2020 לידור משיח. All rights reserved.
//

import Foundation

class ModelSql {
    static let instance = ModelSql();
    var database: OpaquePointer? = nil;
    
    func connect() {
        let dbFileName = "database.db"
        if let dir = FileManager.default.urls(for: .documentDirectory,in: .userDomainMask).first{
            let path = dir.appendingPathComponent(dbFileName);
            if (sqlite3_open(path.absoluteString,&database) != SQLITE_OK) {
                print("Failed to open db file: \(path.absoluteString)");
                return;
            }
        }
        User.createUsersTable();
        Team.createTeamsTable();
        CategoriesModel.createCategoriesTable();
        Post.createPostsTable()
    }
    
    func setLastUpdate(name:String, lastUpdated:Int64){
           var sqlite3_stmt: OpaquePointer? = nil
           if (sqlite3_prepare_v2(database,"INSERT OR REPLACE INTO LAST_UPADATE_DATE( NAME, DATE) VALUES (?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){

               sqlite3_bind_text(sqlite3_stmt, 1, name,-1,nil);
               sqlite3_bind_int64(sqlite3_stmt, 2, lastUpdated);

               if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                   print("new row added succefully")
               }
           }
           sqlite3_finalize(sqlite3_stmt)
       }

       func getLastUpdateDate(name:String)->Int64{
           var date:Int64 = 0;
           var sqlite3_stmt: OpaquePointer? = nil

           if (sqlite3_prepare_v2(database,"SELECT * from LAST_UPADATE_DATE where NAME like ?;",-1,&sqlite3_stmt,nil) == SQLITE_OK){

               sqlite3_bind_text(sqlite3_stmt, 1, name,-1,nil);
               if(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                   date = Int64(sqlite3_column_int64(sqlite3_stmt,1))
               }
           }
           sqlite3_finalize(sqlite3_stmt)
           return date
       }
}
