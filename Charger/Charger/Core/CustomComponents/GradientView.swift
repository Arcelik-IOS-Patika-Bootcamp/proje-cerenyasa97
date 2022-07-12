//
//  GradientView.swift
//  Charger
//
//  Created by Ceren Yaşa on 3.07.2022.
//

import Foundation
import UIKit

class GradientView: UIView{
    let topColor: UIColor = UIColor(red: 68.0/255.0, green: 73.0/255.0, blue: 84.0/255.0, alpha: 1)
    let bottomColor: UIColor = UIColor(red: 23.0/255.0, green: 24.0/255.0, blue: 29.0/255.0, alpha: 1)
    
    var startPointX: CGFloat = 0
    var startPointY: CGFloat = 0
    var endPointX: CGFloat = 1
    var endPointY: CGFloat = 1
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: startPointX, y: startPointY)
        gradientLayer.endPoint = CGPoint(x: endPointX, y: endPointY)
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    
}
