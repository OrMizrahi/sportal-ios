//
//  ModelFirebase.swift
//  ScreensProto
//
//  Created by לידור משיח on 06/01/2020.
//  Copyright © 2020 לידור משיח. All rights reserved.
//

import Foundation
import Firebase

class ModelFirebase{
    
    func addUser(user:User){
        let db = Firestore.firestore()
        let json = user.toJson();
        db.collection("users").document(user.uid).setData(json){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                ModelEvents.PostDataNotification.post();
            }
        }
        /* let db = Firestore.firestore()
         
         // Add a new document with a generated ID
         var ref: DocumentReference? = nil
         ref = db.collection("users").addDocument(data: user.toJson(), completion: { err in
         if let err = err {
         print("Error adding document: \(err)")
         } else {
         print("Document added with ID: \(ref!.documentID)")
         }
         })*/
        
    }
    
    func addTeam(team:Team){
        let db = Firestore.firestore()
        let json = team.toJson();
        db.collection("teams").document(team.teamName).setData(json){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                ModelEvents.PostDataNotification.post();
            }
        }
        /* let db = Firestore.firestore()
         // Add a new document with a generated ID
         var ref: DocumentReference? = nil
         ref = db.collection("teams").addDocument(data: team.toJson(), completion: { err in
         if let err = err {
         print("Error adding document: \(err)")
         } else {
         print("Document added with ID: \(ref!.documentID)")
         }
         })*/
    }
    
    func getAllTeams(since:Int64 ,callback: @escaping ([Team]?)->Void){
        let db = Firestore.firestore();
        db.collection("teams").order(by: "lastUpdate").start(at: [Timestamp(seconds: since, nanoseconds: 0)]).getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)");
                callback(nil);
            }else{
                var data = [Team]();
                for document in querySnapshot!.documents {
                    if let ts = document.data()["lastUpdate"] as? Timestamp {
                        let tsDate = ts.dateValue()
                        print("\(tsDate)")
                        let tsDouble = tsDate.timeIntervalSince1970
                        print("\(tsDouble)")
                    }
                    data.append(Team(json: document.data()));
                }
                callback(data);
            }
        }
    }
    
    func addCategory(category:CategoriesModel){
        let db = Firestore.firestore()
        let json = category.toJson();
        db.collection("categories").document(category.name).setData(json){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                ModelEvents.PostDataNotification.post();
            }
        }
        /* let db = Firestore.firestore()
         // Add a new document with a generated ID
         var ref: DocumentReference? = nil
         ref = db.collection("categories").addDocument(data: category.toJson(), completion: { err in
         if let err = err {
         print("Error adding document: \(err)")
         } else {
         print("Document added with ID: \(ref!.documentID)")
         }
         })*/
    }
    
    func addPost(post:Post){
        /* let db = Firestore.firestore()
         // Add a new document with a generated ID
         var ref: DocumentReference? = nil
         ref = db.collection("posts").addDocument(data: post.toJson(), completion: { err in
         if let err = err {
         print("Error adding document: \(err)")
         } else {
         print("Document added with ID: \(ref!.documentID)")
         }
         })*/
        let db = Firestore.firestore()
        let json = post.toJson();
        db.collection("posts").document(post.postId).setData(json){ err in
            if let err = err {
                print("Error writing document: \(err)")
            } else {
                print("Document successfully written!")
                //ModelEvents.PostDataNotification.post();
            }
        }
    }
    
    func getTeamsByType(since:Int64,types:[String],callback: @escaping ([Team]?)->Void){
        
        let db = Firestore.firestore();
        db.collection("teams").order(by: "lastUpdate").start(at: [Timestamp(seconds: since, nanoseconds: 0)]).getDocuments{ (querySnapshot, err) in
            if let err = err {
               // print("Error getting documents: \(err)");
                callback(nil);
            }else{
                var data = [Team]();
                for document in querySnapshot!.documents {
                    if let ts = document.data()["lastUpdate"] as? Timestamp {
                        let tsDate = ts.dateValue()
                        //print("\(tsDate)")
                        let tsDouble = tsDate.timeIntervalSince1970
                      //  print("\(tsDouble)")
                    }
                    data.append(Team(json: document.data()));
                }
                    var filteredTeams:[Team] = [Team]();
                    for team in data {
                        if(types.contains(team.type)){
                            filteredTeams.append(team);
                        }
                    }
                    callback(filteredTeams);
                }
            }
        }
        
        func getAllCategories(since:Int64 ,callback: @escaping ([CategoriesModel]?)->Void){
            let db = Firestore.firestore();
            db.collection("categories").order(by: "lastUpdate").start(at: [Timestamp(seconds: since, nanoseconds: 0)]).getDocuments{ (querySnapshot, err) in
                if err != nil {
                    //print("Error getting documents: \(err)");
                    callback(nil);
                }else{
                    var data = [CategoriesModel]();
                    for document in querySnapshot!.documents {
                        data.append(CategoriesModel(json: document.data()));
                    }
                    callback(data);
                }
            }
        }
        
   func getAllPostsByTeamName(teamName: String ,callback: @escaping ([Post]?)->Void){
        let db = Firestore.firestore();
        db.collection("posts").getDocuments{ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)");
                callback(nil);
            }else{
                var data = [Post]();
                for document in querySnapshot!.documents {
                    data.append(Post(json: document.data()));
                }
                var filteredPosts:[Post] = [Post]()
                for item in data {
                    if(teamName == item.teamName){
                        filteredPosts.append(item)
                    }
                }
                callback(filteredPosts);
            }
        }
    }
        
        
        
        func getCurrentUserNameByID(callback:@escaping (String?)->Void) {
            
            let userID = Auth.auth().currentUser?.uid;
            let db = Firestore.firestore();
            var name = "";
            
            db.collection("users").whereField("uid", isEqualTo: userID as Any).getDocuments { (querySnapshot, err) in
                if err != nil {
                    //print("Error getting document");
                }else{
                    name = querySnapshot!.documents[0].data()["fullName"] as! String;
                    callback(name);
                }
            }
        }
        
        func updatePost(post:Post) {
            let db = Firestore.firestore();
            db.collection("posts")
                .whereField("postId", isEqualTo: post.postId)
                .getDocuments() { (querySnapshot, err) in
                    if err != nil {}
                    else {
                        let document = querySnapshot!.documents.first
                        document?.reference.updateData([
                            "title": post.title,
                            "content": post.content,
                            "image": post.image])
                    }
            }
        }
        
        func deletePost(post:Post) {
            let db = Firestore.firestore();
            db.collection("posts")
                .whereField("postId", isEqualTo: post.postId)
                .getDocuments() { (querySnapshot, err) in
                    if err != nil {}
                    else {
                        for document in querySnapshot!.documents {
                            document.reference.delete()
                        }
                    }
            }
        }
        
}
