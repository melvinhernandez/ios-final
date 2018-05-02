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
    var image: String?
    
    let dbRef = Database.database().reference()
    
    init() {
        let currentUser = Auth.auth().currentUser
        username = currentUser?.displayName
        id = currentUser?.uid
        getUserImage()
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
    
    /* Get the current user image. */
    func getUserImage() {
        dbRef.child("Users").child(id).child("Image").observeSingleEvent(of: .value, with: { (snapshot) in
            let img = snapshot.value as? String ?? "0"
            self.image = "Img\(img)"
        })
    }
    
    /* Logs out current user */
    func logout() {
        do {
            try Auth.auth().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}
