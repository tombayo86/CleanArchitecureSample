
//  Copyright © 2019 Tom. All rights reserved.

import DomainLayer
import Support
import Swinject
import UIKit
import WebKit

extension ObjectScope {
    static let segue = ObjectScope(storageFactory: PermanentStorage.init)
}

public final class PresentationDependencyInjection: DependencyInjectionLayer {
    
    public static var dependencyInjectionContainer: Container!
    
    public static var managedClasses: [DependencyInjectionAware.Type] {
        return [
            PresentationAppDelegate.self,
            
            WelcomeViewController.self,
            WelcomePresenter.self,
            
            LoginViewController.self,
            LoginFormPresenter.self,
            
        ]
    }
}

