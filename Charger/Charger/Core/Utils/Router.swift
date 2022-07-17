//
//  Router.swift
//  Charger
//
//  Created by Ceren Yaşa on 12.07.2022.
//

import UIKit

enum AppRoute: String{
    case login = "LoginViewController", appointments = "AppointmentsViewController", profile = "ProfileViewController", cities = "CitiesViewController", stations = "StationsViewController",
        dateTime = "DateTimeViewController"
    
}

protocol Router {
   func route(
      to routeID: String,
      from context: UIViewController,
      parameters: Dictionary<String, Any?>?
   )
}

class AppRouter: Router{
    static let shared: AppRouter = AppRouter()
    func route(
       to routeID: String,
       from context: UIViewController,
       parameters: Dictionary<String, Any?>?)
    {
        guard let _ = AppRoute(rawValue: routeID) else {
          return
       }
        
        navigate(id: routeID, context: context, parameters: parameters)
    }
    
    private func navigate(id: String, context: UIViewController, parameters: Dictionary<String, Any?>?){
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: id)
            switch viewController {
            case is StationsViewController:
                let vc = viewController as! StationsViewController
                if let city = parameters?[AppConstants.cityKey] as? String {
                    vc.selectedCity = city
                }
                break
            case is DateTimeViewController:
                let vc = viewController as! DateTimeViewController
                if let station = parameters?[AppConstants.stationKey] as? Station {
                    vc.selectedStation = station
                }
                break
            default:
                break
            }
            context.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
