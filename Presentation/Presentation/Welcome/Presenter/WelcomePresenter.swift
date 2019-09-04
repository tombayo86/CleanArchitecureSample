
//  Copyright © 2019 Tom. All rights reserved.

import DomainLayer
import Foundation
import Support

protocol WelcomePresenting: class {
    func configureDisplay()
    var prefilledEmail: String? { get set }
//    func prepareForPresentation(of presenter: LoginPresenting)
}

protocol WelcomeDisplay: Display {
    func setLoginButtonTitle(_ value: String)
}

protocol WelcomeRouter: Router {}

final class WelcomePresenter: WelcomePresenting {
    
    private weak var display: WelcomeDisplay!
    private weak var router: WelcomeRouter!
    var prefilledEmail: String?
    
    init(display: WelcomeDisplay, router: WelcomeRouter) {
        self.display = display
        self.router = router
    }
    
    func configureDisplay() {
        display.setLoginButtonTitle("Login")
    }
    
//    func prepareForPresentation(of presenter: LoginPresenting) {
//        presenter.prefilledEmail = prefilledEmail
//        prefilledEmail = nil
//    }
}
