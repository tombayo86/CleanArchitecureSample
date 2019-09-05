//
//  AppDelegate.swift
//  CleanArchitectureSample
//
//  Created by Tom on 9/2/19.
//  Copyright © 2019 Tom. All rights reserved.
//

import UIKit
import PresentationLayer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    public var window: UIWindow? = UIWindow()
    
    private var presentationDelegate: UIApplicationDelegate = PresentationAppDelegate()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        (presentationDelegate as! PresentationAppDelegate).window = window
        
        return presentationDelegate.application!(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        presentationDelegate.applicationDidBecomeActive!(application)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        presentationDelegate.applicationWillResignActive!(application)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        presentationDelegate.applicationWillTerminate!(application)
    }
}

