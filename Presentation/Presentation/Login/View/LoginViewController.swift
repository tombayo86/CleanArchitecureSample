
//  Copyright © 2019 Tom. All rights reserved.

import Support
import DomainLayer
import UIKit
import Swinject
import SwinjectStoryboard

final class LoginViewController: UIViewController, DependencyInjectionAware, PresenterSource {
    
    var presenter: LoginPresenting!
    
    @IBOutlet weak var loginTitle: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    // MARK: - DependencyInjectionAware
    
    static func register(inContainer container: Container) {
        container.storyboardInitCompleted(LoginViewController.self) { resolver, controller in
            controller.presenter = resolver.resolve(LoginPresenting.self, arguments: controller as LoginDisplay, controller as LoginRouter)!
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.configureDisplay()
    }
    
    // MARK: - Actions
    
    @IBAction func next(_ sender: Any) {
        guard let email = email.text, let password = password.text else {
            return
        }
        presenter.login(email: email, password: password)
    }
}

extension LoginViewController: LoginDisplay {
    
    func setTitle(_ text: String) {
        loginTitle.text = text
    }
    
    func setNextButtonTitle(_ text: String) {
        nextButton.setTitle(text, for: .normal)
    }
    
    func setEmailField(placeholder: String) {
        email.placeholder = placeholder
    }
    
    func setPasswordField(placeholder: String) {
        password.placeholder = placeholder
    }
}

extension LoginViewController: LoginRouter {
}
