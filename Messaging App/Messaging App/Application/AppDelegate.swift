//
//  AppDelegate.swift
//  Messaging App
//
//  Created by Burak Çokyıldırım on 8.02.2020.
//  Copyright © 2020 Softbea. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NetworkService.sharedInstance.startReachability { (status) in
            
        }
        
        UIApplication.shared.applicationSupportsShakeToEdit = false
        
        addWindowSizeHandlerForMacOS()
        
        if #available(iOS 13.0, *) {
            self.window?.overrideUserInterfaceStyle = .light
        } else {
            let splashScreen: SplashViewController = UIStoryboard.Login.instantiateViewController()
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window!.rootViewController = splashScreen
            self.window?.makeKeyAndVisible()
        }
        
        return true
    }
    
    func addWindowSizeHandlerForMacOS() {
        if #available(iOS 13.0, *) {
            UIApplication.shared.connectedScenes.compactMap { $0 as? UIWindowScene }.forEach { windowScene in
                windowScene.sizeRestrictions?.minimumSize = CGSize(width: 800, height: 1100)
                windowScene.sizeRestrictions?.maximumSize = CGSize(width: 800, height: 1100)
            }
        }
    }
    

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

