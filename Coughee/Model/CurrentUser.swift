//
//  CurrentUser.swift
//  Coughee
//
//  Created by Melvin  Hernandez on 4/26/18.
//  Copyright © 2018 UC Berkeley. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class CurrentUser {
    
    var username: String!
    var id: String!
    var postsIDs: [String]?
    
    let dbRef = Database.database().reference()
    
    init() {
        let currentUser = Auth.auth().currentUser
        username = currentUser?.displayName
        id = currentUser?.uid
    }
    
    /*
     Gets the posts IDs for the current user.
     */
    func getPosts(completion: @escaping ([String]) -> Void) {
        var postArray: [String] = []
        dbRef.child("Users").child(id).child("Posts").observeSingleEvent(of: .value, with: { (snapshot) in
            let postDict = snapshot.value as? [String : AnyObject] ?? [:]
            for (_, postId) in postDict {
                postArray.append((postId as? String)!)
            }
            completion(postArray)
        })
    }
    
    /*
     Add new post to current user.
     */
    func addNewPost(postID: String) {
        let ref = dbRef.child("Users").child(id).child("Posts").childByAutoId()
        ref.setValue(postID)
    }
    
}
