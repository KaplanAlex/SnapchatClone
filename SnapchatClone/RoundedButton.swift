//
//  RoundedButton.swift
//  SnapchatClone
//
//  Created by Alexander Kaplan on 8/1/16.
//  Copyright © 2016 develop. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundedButton: UIButton{
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor?{
        didSet{
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var bgColor: UIColor?{
        didSet{
            backgroundColor = bgColor
        }
    }
}
