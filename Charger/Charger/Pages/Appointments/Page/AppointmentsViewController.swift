//
//  AppointmentsViewController.swift
//  Charger
//
//  Created by Ceren Yaşa on 12.07.2022.
//

import UIKit

class AppointmentsViewController: UIViewController {
    
    var viewModel: AppointmentsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = AppointmentsViewModel()
        navigationItem.hidesBackButton = true
    }
    
    @IBAction func navigateToProfile(_ sender: Any) {
        viewModel?.navigateToProfile(context: self)
    }
    
    @IBAction func madeAnAppointment(_ sender: Any) {
        viewModel?.navigateToCities(context: self)
    }
}
