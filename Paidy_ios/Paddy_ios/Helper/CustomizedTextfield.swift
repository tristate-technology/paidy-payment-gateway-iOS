//
//  CustomizedTextfield.swift
//  Paidy_ios
//
//  Created by Tristate on 22/04/19.
//  Copyright © 2019 Tristate. All rights reserved.
//

import UIKit

class CustomizedTextfield: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 2.0
        self.layer.masksToBounds = true
    }
    
    
    @IBInspectable var padding: CGFloat = 0
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + padding, y: bounds.origin.y, width: bounds.width - padding * 2, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + padding, y: bounds.origin.y, width: bounds.width - padding * 2, height: bounds.height)
    }

}
