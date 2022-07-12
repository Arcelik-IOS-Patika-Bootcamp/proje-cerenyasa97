//
//  LoginViewController.swift
//  Charger
//
//  Created by Ceren Yaşa on 27.06.2022.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    
    var viewModel: LoginViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = LoginViewModel(ctx: self)
        
        navigationItem.hidesBackButton = true  
    }
    
    @IBAction func logIn(_ sender: Any) {
        Task{
            await login()
        }
    }
    
    func login() async {
        if let email = emailField.text, let vm = viewModel, let udid = UIDevice.current.identifierForVendor?.uuidString {
            if(email.validateEmail()){
                let result = await vm.logIn(email: email, udid: udid)
                print(result)
            }
        } else {
            print("Please enter email.")
        }
    }
}
