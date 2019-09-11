
//  Copyright © 2019 Tom. All rights reserved.

import DomainLayer
import RxSwift
import Support
import UIKit
import Swinject

// MARK: - App delegate

public final class PresentationAppDelegate: NSObject, UIApplicationDelegate, DependencyInjectionAware {
    
    public var window: UIWindow? = UIWindow()
    
    // MARK: - Lifecycle
    
    public func application(
        _ : UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        let welcomeViewController: UIViewController = UIStoryboard(name: "Welcome", bundle: .current).instantiateInitialViewController()!
        window!.rootViewController = welcomeViewController
        window!.isHidden = false
        window!.makeKeyAndVisible()
        
        return true
    }
    
    // MARK: - DependencyInjectionAware
    
    public static func register(inContainer container: Container) {
        container.register(UIApplicationDelegate.self) { (resolver: Resolver) in
            PresentationAppDelegate()
            }.inObjectScope(.container)
    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    public func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    public func applicationWillTerminate(_ application: UIApplication) {
        
    }
}
