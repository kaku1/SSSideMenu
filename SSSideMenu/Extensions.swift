//
//  Extensions.swift
//  Bounce
//
//  Created by Siddhant Saxena on 23/03/18.
//  Copyright © 2018 Siddhant Saxena. All rights reserved.
//

import Foundation
import UIKit

////// uicolor extension

public extension UIColor {

    convenience public init(rgbValue: Int, alpha: CGFloat) {
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha)
        
        
    }
    
}

////// uivew extension

public extension UIView {
    
    
    public func addBottomBorder(withThickness: Int,andColor: Int){
        let viewHeight = self.frame.height
        let viewWidth = self.frame.width
        let rect = CGRect(origin: CGPoint(x: 0,y :viewHeight), size: CGSize(width: viewWidth, height: 1))
        var bottomBorder: UIView = UIView.init(frame: rect)
        bottomBorder.backgroundColor = UIColor.init(rgbValue: andColor, alpha: 1)
        
        self.addSubview(bottomBorder)
    }
    
    public func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
    public func setCardBorderAndShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true, cardRadius: CGFloat = 5){
        self.layer.masksToBounds = false
        self.layer.cornerRadius = cardRadius
        self.backgroundColor = .white
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.init(rgbValue: 0x25265E, alpha: 00.1).cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        
    }
    
    public func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    
}
