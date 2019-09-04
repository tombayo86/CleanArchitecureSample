
//  Copyright © 2019 Tom. All rights reserved.

import DomainLayer
import RxSwift
import Support
import UIKit

// MARK: - App delegate

public final class PresentationAppDelegate: NSObject, UIApplicationDelegate {
    
    public var window: UIWindow? = UIWindow()
    
    // Used to make code clearer below because we cannot change the name of window.
    private var welcomeWindow: UIWindow {
        return window!
    }
    
    private var mainWindow: UIWindow!
    private var maskWindow: UIWindow?

    private let disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    
    public func applicationDidBecomeActive(_ application: UIApplication) {
       
    }
    
    public func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    public func applicationWillTerminate(_ application: UIApplication) {
        
    }
    
    // MARK: - UINavigationBarDelegate
    
    public func application(
        _: UIApplication,
        didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        
        let welcomeViewController: UIViewController = UIStoryboard(name: "Welcome", bundle: .current).instantiateInitialViewController()!
        welcomeWindow.rootViewController = welcomeViewController
        welcomeWindow.isHidden = false
        welcomeWindow.makeKeyAndVisible()
        
        return true
    }
}
