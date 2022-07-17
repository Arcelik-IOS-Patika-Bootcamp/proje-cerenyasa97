//
//  CustomTextField.swift
//  Charger
//
//  Created by Ceren Yaşa on 3.07.2022.
//

import Foundation
import UIKit

class CustomTextField: UITextField{
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpUnderlinedTextField()
    }
    
    func setUpUnderlinedTextField(){
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: self.frame.height + 5, width: self.frame.width, height: 2)
        bottomLayer.backgroundColor = UIColor.white.cgColor
        self.borderStyle = .none
        self.backgroundColor = .clear
        self.textColor = UIColor(red: 165/255, green: 169/255, blue: 181/255, alpha: 1)
        self.layer.addSublayer(bottomLayer)
    }
}
