//
//  ViewController.swift
//  Charger
//
//  Created by Ceren Yaşa on 27.06.2022.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    var viewModel: SplashViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigateToLogin()
        navigationController?.setStatusBar(backgroundColor: UIColor(red: 68/255, green: 73/255, blue: 84/255, alpha: 1))
        viewModel = SplashViewModel()
    }
    
    func navigateToLogin(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            [weak self] in
            if let vc = self{
                vc.viewModel?.navigateToLogin(context: vc)
            }
        }
    }
}
