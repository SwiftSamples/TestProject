//
//  AppDelegate.swift
//  TestProject
//
//  Created by Swapna Botta on 10/07/23.
//

import UIKit
import GoogleMaps
import GooglePlaces
@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
    //    Global.shared.globalCall()//https://maps.googleapis.com/maps/api/js?key=&callback=initMap
        GMSServices.provideAPIKey("AIzaSyAtJA-OIBFD_7anP50CHgUks5J1qfK25Mg")
        GMSPlacesClient.provideAPIKey("AIzaSyAneRO7LlfgaFBBH840yIdcKTL5sP866Aw")//iwi key using for places
        //AIzaSyAtJA-OIBFD_7anP50CHgUks5J1qfK25Mg
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

