//
//  SplashViewModel.swift
//  Charger
//
//  Created by Ceren Yaşa on 30.06.2022.
//

import Foundation
import UserNotifications
import CoreLocation

class SplashViewModelProtocol{
    func requestNotificationPermission(){}
    func requestLocationPermission(){}
    func navigateToLogin(context: SplashViewController){}
}

class SplashViewModel: SplashViewModelProtocol, BaseViewModel{
    var notificationPermission: Bool = false
    
    override init() {
        super.init()
        requestLocationPermission()
        requestNotificationPermission()
    }
    
    override func requestNotificationPermission(){
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
            self.notificationPermission = granted
            if(granted){
                print("Notification permission was granted")
            }
        }
    }
    
    override func requestLocationPermission(){
        let locationManager: CLLocationManager = CLLocationManager()
        locationManager.requestWhenInUseAuthorization()
    }
    
    override func navigateToLogin(context: SplashViewController) {
        AppRouter.shared.route(to: AppRoute.login.rawValue, from: context, parameters: nil)
    }
}
