
//  Copyright © 2019 Tom. All rights reserved.

import DomainLayer
import Foundation
import Support
import Swinject

protocol WelcomePresenting: class {
    func configureDisplay()
}

protocol WelcomeDisplay: Display {
    func setLoginButtonTitle(_ value: String)
}

protocol WelcomeRouter: Router {}

final class WelcomePresenter: WelcomePresenting, DependencyInjectionAware {
    
    private weak var display: WelcomeDisplay!
    private weak var router: WelcomeRouter!
    
    // MARK: - DependencyInjectionAware
    
    public static func register(inContainer container: Container) {
        container.register(WelcomePresenting.self) { (resolver: Resolver, display: WelcomeDisplay, router: WelcomeRouter) in
            WelcomePresenter(display: display, router: router)
            }.inObjectScope(.transient)
    }
    
    // MARK: - Lifecycle
    
    init(display: WelcomeDisplay, router: WelcomeRouter) {
        self.display = display
        self.router = router
    }
    
    func configureDisplay() {
        display.setLoginButtonTitle("Login")
    }
}
