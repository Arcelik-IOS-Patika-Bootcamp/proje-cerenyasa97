//
//  Router.swift
//  Charger
//
//  Created by Ceren Yaşa on 12.07.2022.
//

import UIKit

enum AppRoute: String{
    case login = "LoginViewController", appointments = "AppointmentsViewController", profile = "ProfileViewController"
}

protocol Router {
   func route(
      to routeID: String,
      from context: UIViewController,
      parameters: Any?
   )
}

class AppRouter: Router{
    static let shared: AppRouter = AppRouter()
    func route(
       to routeID: String,
       from context: UIViewController,
       parameters: Any?)
    {
        guard let _ = AppRoute(rawValue: routeID) else {
          return
       }
        
        navigate(id: routeID, context: context)
    }
    
    private func navigate(id: String, context: UIViewController){
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: id)
            context.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
