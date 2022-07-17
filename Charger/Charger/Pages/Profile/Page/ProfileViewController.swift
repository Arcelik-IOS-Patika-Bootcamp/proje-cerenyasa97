//
//  ProfileViewController.swift
//  Charger
//
//  Created by Ceren Yaşa on 12.07.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var id: UILabel!
    
    var viewModel: ProfileViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        email.text = AuthManager.shared.userInfo?.email
        id.text = UIDevice.current.identifierForVendor?.uuidString
        
        viewModel = ProfileViewModel()
    }
    
    @IBAction func logOut(_ sender: Any) {
        Task{
            await viewModel?.logOut(context: self)
        }
    }
}
