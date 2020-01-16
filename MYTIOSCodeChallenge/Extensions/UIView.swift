//
//  UIView.swift
//  MYTIOSCodeChallenge
//
//  Created by Waqas Naseem on 19/10/2019.
//  Copyright © 2019 Waqas Naseem. All rights reserved.
//

import UIKit

extension UIView {
    
    /// Helper method to set all anchoors of a view
    /// - Parameter top: top anchor
    /// - Parameter left: left anchor
    /// - Parameter bottom: bottom anchor
    /// - Parameter right: right anchor
    /// - Parameter paddingTop: padding from top
    /// - Parameter paddingLeft: padding from left
    /// - Parameter paddingBottom: padding from bottom
    /// - Parameter paddingRight: padding from right
    /// - Parameter width: widht constant
    /// - Parameter height: height constant
    /// - Parameter enableInsets: should enable Insets
    func anchor (top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool) {
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)
        
        if #available(iOS 11, *), enableInsets {
            let insets = self.safeAreaInsets
            topInset = insets.top
            bottomInset = insets.bottom
            print("Top: \(topInset)")
            print("bottom: \(bottomInset)")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
    }
}
