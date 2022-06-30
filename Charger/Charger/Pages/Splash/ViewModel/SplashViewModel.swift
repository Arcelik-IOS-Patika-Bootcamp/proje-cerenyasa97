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
}

class SplashViewModel: SplashViewModelProtocol{
    var notificationPermission: Bool = false
    
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
}
