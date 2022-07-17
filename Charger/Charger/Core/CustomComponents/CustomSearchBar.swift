//
//  CustomSearchBar.swift
//  Charger
//
//  Created by Ceren Yaşa on 13.07.2022.
//

import Foundation
import UIKit

class CustomSearchBar: UISearchBar{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customizeSearchBar()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        makeTransparentBackground()
    }

    private func makeTransparentBackground() {
        for view in self.subviews {
            view.backgroundColor = UIColor.clear
            for subview in view.subviews {
                if let imageview = subview as? UIImageView {
                    imageview.image = nil
                }
            }
        }
    }
    
    func customizeSearchBar(){
        let textField = self.searchTextField
        textField.borderStyle = .none
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
        textField.layer.cornerRadius = 16
        textField.leftView?.tintColor = .white
        textField.textColor = UIColor(red: 165/255, green: 169/255, blue: 181/255, alpha: 1)
        textField.backgroundColor = UIColor(red: 28/255, green: 30/255, blue: 37/255, alpha: 1)
    }
}
