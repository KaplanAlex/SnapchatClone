//
//  AuthService.swift
//  SnapchatClone
//
//  Created by Alexander Kaplan on 8/2/16.
//  Copyright © 2016 develop. All rights reserved.
//

import Foundation
import FirebaseAuth


typealias Completion = (errMsg: String?, data: AnyObject?) -> Void

class AuthService{
    private static let _instance = AuthService()
    
    static var instance: AuthService{
        return _instance
    }
    
    func login(email: String, password: String, onComplete: Completion?){
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
           
            
            if error != nil{
                if let errorCode = FIRAuthErrorCode(rawValue: error!.code){
                    if errorCode == .errorCodeUserNotFound{
                       
                        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: {(user, error) in
                            if error != nil{
                                self.handleFirebaseError(error: error!, onComplete: onComplete)
                            }else{
                                if user?.uid != nil{
                                    //Sign in
                                    DataService.instance.saveUser(uid: user!.uid)
                                    FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                                        if error != nil{
                                            self.handleFirebaseError(error: error!, onComplete: onComplete)
                                        }else{
                                            //we have successfully logged in
                                            onComplete?(errMsg: nil, data: user)
                                        }
                                    })
                                }
                            }
                       })
                    }
                        
                
                }else{
                    //Handle all other errors
                    self.handleFirebaseError(error: error!, onComplete: onComplete)
                }
            }else{
                //Successfully logged in
                onComplete?(errMsg: nil, data: user)
                print("Logged in")
            }
        })
    }
    
    func handleFirebaseError(error: NSError, onComplete: Completion?){
        print(error.debugDescription)
        if let errorCode = FIRAuthErrorCode(rawValue: error.code){
            switch (errorCode){
                case .errorCodeInvalidEmail:
                    onComplete?(errMsg: "Invalid email address", data: nil)
                    break
                case .errorCodeWrongPassword:
                    onComplete?(errMsg: "Invalid password", data: nil)
                case .errorCodeEmailAlreadyInUse, .errrorCodeAccountExistsWithDifferentCredential:
                    onComplete?(errMsg: "Email already in use", data: nil)
                default:
                    onComplete?(errMsg: "There was a problem authenticating. Try again.", data: nil)
                
            }
        }
    }
}
