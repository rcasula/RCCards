//
//  UIView.swift
//  RCCards
//
//  Created by Roberto Casula on 10/11/2018.
//

import Foundation


public extension UIView {
    
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.fillColor = self.backgroundColor?.cgColor
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}
