
//  Copyright © 2019 Tom. All rights reserved.

import DomainLayer
import RxSwift
import Support
import UIKit

// MARK: - App delegate

public final class PresentationAppDelegate: NSObject, UIApplicationDelegate {
    
    public var window: UIWindow?
    
    // MARK: - Lifecycle
    
    public func application(
        _ : UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        let welcomeViewController: UIViewController = UIStoryboard(name: "Welcome", bundle: .current).instantiateInitialViewController()!
        
        window!.backgroundColor = UIColor.white
        window!.rootViewController = welcomeViewController
        window!.isHidden = false
        window!.makeKeyAndVisible()
        
        return true
    }
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    public func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    public func applicationWillTerminate(_ application: UIApplication) {
        
    }
}
