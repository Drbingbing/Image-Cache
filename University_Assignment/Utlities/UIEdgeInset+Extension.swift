//
//  UIEdgeInset+Extension.swift
//  University_Assignment
//
//  Created by Bing Bing on 2024/4/20.
//

import Foundation
import UIKit

extension UIEdgeInsets {
    
    init(_ all: CGFloat) {
        self.init(top: all, left: all, bottom: all, right: all)
    }
    
    init(h: CGFloat) {
        self.init(top: 0, left: h, bottom: 0, right: h)
    }
    
    init(v: CGFloat) {
        self.init(top: v, left: 0, bottom: v, right: 0)
    }
    
    init(h: CGFloat, v: CGFloat) {
        self.init(top: v, left: h, bottom: v, right: h)
    }
    
    init(left: CGFloat) {
        self.init(top: 0, left: left, bottom: 0, right: 0)
    }
    
    init(bottom: CGFloat) {
        self.init(top: 0, left: 0, bottom: bottom, right: 0)
    }
    
    init(right: CGFloat) {
        self.init(top: 0, left: 0, bottom: 0, right: right)
    }
    
    init(top: CGFloat) {
        self.init(top: top, left: 0, bottom: 0, right: 0)
    }
}

extension UIEdgeInsets {
    
    var horizontal: CGFloat {
        left + right
    }
    
    var vertical: CGFloat {
        top + bottom
    }
}
