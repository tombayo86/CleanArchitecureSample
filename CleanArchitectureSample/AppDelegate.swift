//
//  AppDelegate.swift
//  CleanArchitectureSample
//
//  Created by Tom on 9/2/19.
//  Copyright © 2019 Tom. All rights reserved.
//

import UIKit
import PresentationLayer
import DataLayer
import DomainLayer
import SwinjectStoryboard
import Swinject

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Initialize all the DependencyInjection managed classes
        DataDependencyInjection.initialize()
        DomainDependencyInjection.initialize(withParentContainer: DataDependencyInjection.dependencyInjectionContainer)
        PresentationDependencyInjection.initialize(withParentContainer: DomainDependencyInjection.dependencyInjectionContainer)
        
        Container.loggingFunction = {
            
            // Find the text that contains the missing registration.
            if let startOfMissingRegistration = $0.range(of: "Swinject: Resolution failed. Expected registration:\n\t")?.upperBound,
                let startOfAvailableOptions = $0.range(of: "\nAvailable registrations:")?.lowerBound {
                let missingRegistration = $0[startOfMissingRegistration ..< startOfAvailableOptions]
                
                // Ignore all reports for UIKit classes.
                if missingRegistration.contains("Storyboard: UI")
                    || missingRegistration.contains("Storyboard: PresentationLayer.MenuNavigationController")
                    || missingRegistration.contains("Storyboard: PresentationLayer.NavigationMenuContainerViewController") {
                    return
                }
                
                // Print the missing registration.
                print("Swinject failed to find registration for \(missingRegistration)")
                return
            }
            
            // Some other message so just print it.
            print($0)
        }
        
        SwinjectStoryboard.defaultContainer = PresentationDependencyInjection.dependencyInjectionContainer

        let delegate = PresentationDependencyInjection.dependencyInjectionContainer.resolve(UIApplicationDelegate.self)!
        
        return delegate.application!(application, didFinishLaunchingWithOptions: launchOptions)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        presentationAppDelegate().applicationDidBecomeActive!(application)
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        presentationAppDelegate().applicationWillResignActive!(application)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        presentationAppDelegate().applicationWillTerminate!(application)
    }
    
    private func presentationAppDelegate() -> UIApplicationDelegate {
        return PresentationDependencyInjection.dependencyInjectionContainer.resolve(UIApplicationDelegate.self)!
    }
}

