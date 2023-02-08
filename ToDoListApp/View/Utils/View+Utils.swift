//
//  View+Utils.swift
//  ToDoListApp
//
//  Created by Nathan Batista on 06/02/23.
//

import UIKit

extension UIView {
    
    var borderWidth: CGFloat {
        get { return self.layer.borderWidth }
        set { self.layer.borderWidth = newValue }
    }
    
    var borderColor: UIColor? {
        get { return self.layer.borderColor != nil ? UIColor(cgColor: self.layer.borderColor!) : nil }
        set { self.layer.borderColor = newValue?.cgColor }
    }
    
    var cornerRadius: CGFloat {
        get { return self.layer.cornerRadius }
        set { self.layer.cornerRadius = newValue }
    }
    
}
