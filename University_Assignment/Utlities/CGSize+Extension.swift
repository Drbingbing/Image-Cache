//
//  CGSize.swift
//  University_Assignment
//
//  Created by Bing Bing on 2024/4/20.
//

import UIKit
import Foundation

extension CGSize {
    
    func inset(by insets: UIEdgeInsets) -> CGSize {
        return CGSize(width: width - insets.left - insets.right, height: height - insets.top - insets.bottom)
    }
    
    func offset(by insets: UIEdgeInsets) -> CGSize {
        return CGSize(width: width + insets.left + insets.right, height: height + insets.top + insets.bottom)
    }
}
