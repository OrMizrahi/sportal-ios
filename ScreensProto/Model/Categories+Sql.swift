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
        let res = sqlite3_exec(ModelSql.instance.database, "CREATE TABLE IF NOT EXISTS CATEGORY ( CATEGORYNAME TEXT PRIMARY KEY)",nil,nil, &errorMsg);
        if(res != 0){
            //print("error in creating table");
            return;
        } else{
            //print("table was created");
            return;
        }
    }
    
    func addCategory(){
        var sqlite3_stmt: OpaquePointer? = nil;
        if(sqlite3_prepare_v2(ModelSql.instance.database,"INSERT OR REPLACE INTO CATEGORY(CATEGORYNAME) VALUES (?);",-1,&sqlite3_stmt,nil) == SQLITE_OK){
            let category = self.name.cString(using: .utf8);
            sqlite3_bind_text(sqlite3_stmt,1,category,-1,nil);

            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
                //print("new row added succesfully");
            }
        }
    }
    
    static func getAllCategoriesFromDb()->[CategoriesModel]{
        var sqlite3_stmt: OpaquePointer? = nil
        var data = [CategoriesModel]()
        if(sqlite3_prepare_v2(ModelSql.instance.database,"SELECT * from CATEGORY;",-1,&sqlite3_stmt,nil) == SQLITE_OK){
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let categoryName = String(cString:sqlite3_column_text(sqlite3_stmt,0)!)
                let ct = CategoriesModel(name:categoryName);
                data.append(ct)
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        return data
    }
    
   
    
     static func setLastUpdate(lastUpdated:Int64){
         return ModelSql.instance.setLastUpdate(name: "CATEGORY", lastUpdated: lastUpdated);
     }

     static func getLastUpdateDate()->Int64{
         return ModelSql.instance.getLastUpdateDate(name: "CATEGORY")
     }
}
