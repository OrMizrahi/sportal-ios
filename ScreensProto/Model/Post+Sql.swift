
import Foundation


extension Post {
    
    static func createPostsTable(){
        var errormsg: UnsafeMutablePointer<Int8>? = nil
        let res = sqlite3_exec(ModelSql.instance.database, "CREATE TABLE IF NOT EXISTS POSTS (POST_ID TEXT PRIMARY KEY, TITLE TEXT, DATE TEXT, IMAGE TEXT, CONTENT TEXT, TEAMNAME TEXT, POSTCREATOR TEXT)", nil, nil, &errormsg);
        if(res != 0){
            return
        }
    }
    
    
    
    func addToDb(){
        var sqlite3_stmt: OpaquePointer? = nil
        
        if (sqlite3_prepare_v2(ModelSql.instance.database,"INSERT OR REPLACE INTO POSTS(POST_ID, TITLE, DATE, IMAGE, CONTENT, TEAMNAME, POSTCREATOR) VALUES (?,?,?,?,?,?,?);",-1, &sqlite3_stmt,nil) == SQLITE_OK){
            
            let postId = self.postId.cString(using: .utf8)
            let title = self.title.cString(using: .utf8)
            let date = self.date.cString(using: .utf8)
            let image = self.image.cString(using: .utf8)
            let content = self.content.cString(using: .utf8)
            let teamName = self.teamName.cString(using: .utf8)
            let postCreator = self.postCreator.cString(using: .utf8)
            
            sqlite3_bind_text(sqlite3_stmt, 1, postId,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 2, title,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 3, date,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 4, image,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 5, content,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 6, teamName,-1,nil);
            sqlite3_bind_text(sqlite3_stmt, 7, postCreator,-1,nil);
            
            if(sqlite3_step(sqlite3_stmt) == SQLITE_DONE){
            }
        }
        sqlite3_finalize(sqlite3_stmt)
    }
    
    
    
    static func getAllPostsFromDb(teamName:String)->[Post]{
        var sqlite3_stmt: OpaquePointer? = nil
        var data = [Post]()
        
        if (sqlite3_prepare_v2(ModelSql.instance.database,"SELECT * from POSTS;",-1,&sqlite3_stmt,nil) == SQLITE_OK){
            
            while(sqlite3_step(sqlite3_stmt) == SQLITE_ROW){
                let postId = String(cString:sqlite3_column_text(sqlite3_stmt,0)!)
                let title = String(cString:sqlite3_column_text(sqlite3_stmt,1)!)
                let date = String(cString:sqlite3_column_text(sqlite3_stmt,2)!)
                let image = String(cString:sqlite3_column_text(sqlite3_stmt,3)!)
                let content = String(cString:sqlite3_column_text(sqlite3_stmt,4)!)
                let teamName = String(cString:sqlite3_column_text(sqlite3_stmt,5)!)
                let postCreator = String(cString:sqlite3_column_text(sqlite3_stmt,6)!)
                
                let post = Post(title: title, date: date, image: image, content: content, teamName: teamName, postId: postId, creator: postCreator)
                
                data.append(post)
            }
        }
        sqlite3_finalize(sqlite3_stmt)
        var filteredTeams:[Post] = [Post]();
        for post in data {
            if(post.teamName == teamName){
                filteredTeams.append(post);
            }
        }
        return filteredTeams
    }
    
    static func updatePostOnSql(post:Post){
        let postId = post.postId.cString(using: .utf8)
        let imgUrl = post.image.cString(using: .utf8)
        let content = post.content.cString(using: .utf8)
        let title = post.title.cString(using: .utf8)
        
        let updateStatementString = "UPDATE POSTS SET TITLE = ?, CONTENT = ?, IMAGE = ?   WHERE POST_ID = ?;"
        var updateStatement: OpaquePointer?
        if sqlite3_prepare_v2(ModelSql.instance.database, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK{
            sqlite3_bind_text(updateStatement, 1, title, -1, nil)
            sqlite3_bind_text(updateStatement, 2, content, -1, nil)
            sqlite3_bind_text(updateStatement, 3, imgUrl, -1, nil)
            sqlite3_bind_text(updateStatement, 4, postId, -1, nil)
            
            
            if sqlite3_step(updateStatement) == SQLITE_DONE{}
        }
        sqlite3_finalize(updateStatement)
    }
    
    static func deletePostOnSql(post:Post){
        
        let deleteStatementStirng = "DELETE FROM POSTS WHERE POST_ID = ?;"
        
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(ModelSql.instance.database, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(deleteStatement, 1, post.postId,-1,nil)
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("DELETING!")
            }
        }
        sqlite3_finalize(deleteStatement)
    }
    
    
    
    static func setLastUpdate(lastUpdated:Int64){
        return ModelSql.instance.setLastUpdate(name: "POSTS", lastUpdated: lastUpdated);
    }
    
    static func getLastUpdateDate()->Int64{
        return ModelSql.instance.getLastUpdateDate(name: "POSTS")
    }
}
