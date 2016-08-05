//
//  DataService.swift
//  SnapchatClone
//
//  Created by Alexander Kaplan on 8/2/16.
//  Copyright © 2016 develop. All rights reserved.
//

let FIR_CHILD_USERS = "users"

import Foundation
import FirebaseDatabase
import FirebaseStorage

class DataService{
    private static let _instance = DataService()
    
    static var instance: DataService{
        return _instance
    }
    
    var currentPageIndex: Int = 1
    
    var mainReference: FIRDatabaseReference{
        return FIRDatabase.database().reference()
    }
    
    var userRef: FIRDatabaseReference{
        return mainReference.child(FIR_CHILD_USERS)
    }
    
    var mainStorageRef: FIRStorageReference{
        return FIRStorage.storage().reference(forURL: "gs://snapchatclone-f8ce6.appspot.com")
    }
    
    var imagesStorageRef: FIRStorageReference{
        return mainStorageRef.child("images")
    }
    
    var videoStorageRef: FIRStorageReference{
        return mainStorageRef.child("videos")
    }
    
    func saveUser(uid: String){
        let profile: Dictionary<String, AnyObject> = ["firstName": "", "lastName": ""]
        mainReference.child("users").child(uid).child("profile").setValue(profile)
    }
    
    func sendMediaPullRequest(senderUID: String, sendingTo: Dictionary<String, User> , mediaURL: URL, textSnippet: String? = nil){
        
        var uids = [String]()
        for uid in sendingTo.keys{
            uids.append(uid)
        }
        
        var pr: Dictionary<String,AnyObject> = ["mediaURL":mediaURL.absoluteString!, "userID":senderUID, "openCount": 0, "recipients": uids]
        
        mainReference.child("pullRequests").childByAutoId().setValue(pr)
    }
}
