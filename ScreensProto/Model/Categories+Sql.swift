//
//  Categories+Sql.swift
//  ScreensProto
//
//  Created by לידור משיח on 15/01/2020.
//  Copyright © 2020 לידור משיח. All rights reserved.
//

import Foundation

extension CategoriesModel{
    
   static func createCategoriesTable(){
           var errorMsg: UnsafeMutablePointer<Int8>? = nil;
        let res = sqlite3_exec(ModelSql.instance.database, "CREATE TABLE IF NOT EXISTS CATEGORIES ( CATEGORYNAME TEXT PRIMARY KEY)",nil,nil, &errorMsg);
           if(res != 0){
               print("error in creating table");
               return;
           } else{
               print("table was created");
               return;
               }
       }
       
       func addCategory(){
              var sqlite3_stmt: OpaquePointer? = nil;
        if(sqlite3_prepare_v2(ModelSql.instance.database,"INSERT OR REPLACE INTO CATEGORIES(CATEGORYNAME) VALUES (?);",-1,&sqlite3_stmt,nil) == SQLITE_OK){
               let category = self.name.cString(using: .utf8);
             
               sqlite3_bind_text(sqlite3_stmt,1,category,-1,nil);
                 
                  if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                      print("new row added succesfully");
                  }
              }
          }
    
}
