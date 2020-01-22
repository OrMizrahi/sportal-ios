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
    }


    
   
    
    
   
    
}
