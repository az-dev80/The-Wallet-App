//
//  GradientBorderAndShadow.swift
//  rss.ios.stage3-task12
//
//  Created by Albert Zhloba on 9.10.21.
//

import UIKit

class GradientBorderAndShadow {
    class func setBorderGradientAndShadow(viewL:UIView, radius: CGFloat = 20){
        let gradient = CAGradientLayer()
        gradient.frame =  CGRect(origin: CGPoint.zero, size: viewL.frame.size)
        gradient.colors = [UIColor(red: 1, green: 1, blue: 0.984, alpha: 0.40).cgColor, UIColor(red: 1, green: 1, blue: 0.984, alpha: 0.90).cgColor]
        gradient.startPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.locations = [0, 1]
        gradient.cornerRadius = radius
        gradient.cornerCurve = .continuous
        
        let shape = CAShapeLayer()
        shape.lineWidth = 3
        shape.path = UIBezierPath(roundedRect: viewL.bounds, cornerRadius: 20).cgPath
        
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        viewL.layer.addSublayer(gradient)
        
        viewL.layer.shadowPath = shape.path
        viewL.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.05).cgColor
        viewL.layer.shadowOpacity = 1
        viewL.layer.shadowRadius = 100
        viewL.layer.shadowOffset = CGSize(width: 5, height: 5)
    }
}

