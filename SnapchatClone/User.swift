//
//  User.swift
//  SnapchatClone
//
//  Created by Alexander Kaplan on 8/2/16.
//  Copyright © 2016 develop. All rights reserved.
//

import UIKit

struct User{
    private var _firstName: String
    private var _uid: String
    
    var uid: String{
        return _uid
    }
    
    var firstName: String{
        return _firstName
    }
    
    init(uid: String, firstName: String){
        _uid = uid
        _firstName = firstName
    }
}
