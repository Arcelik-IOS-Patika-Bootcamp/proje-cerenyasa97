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
    
    @IBOutlet weak var lottieView: AnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lottieAnimation()
        
        viewModel = SplashViewModel()
    }
    
    func lottieAnimation(){
        lottieView = AnimationView(name: "splash_animation")
        lottieView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        lottieView.center = self.view.center
        lottieView.contentMode = .scaleAspectFit
        view.addSubview(lottieView)
        viewModel?.requestNotificationPermission()
        viewModel?.requestLocationPermission()
        lottieView.play { completed in
            if(completed){
                let loginViewController = LoginViewController()
                self.navigationController?.pushViewController(loginViewController, animated: true)}
        }
    }
}

