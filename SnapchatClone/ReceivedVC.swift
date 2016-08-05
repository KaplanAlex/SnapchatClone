//
//  ReceivedVC.swift
//  SnapchatClone
//
//  Created by Alexander Kaplan on 8/3/16.
//  Copyright © 2016 develop. All rights reserved.
//

import UIKit

class ReceivedVC: UIViewController {

    var pageIndex: Int!
    var titleIndex: String!
    var imageFile: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pageIndex = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DataService.instance.currentPageIndex = 0
    }


}
