
//  Copyright © 2019 Tom. All rights reserved.

import Support
import UIKit
import Swinject
import SwinjectStoryboard

final class WelcomeViewController: UIViewController, DependencyInjectionAware, WelcomeRouter, WelcomeDisplay, PresenterSource {
    
    var presenter: WelcomePresenting!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - DependencyInjectionAware
    
    static func register(inContainer container: Container) {
        container.storyboardInitCompleted(WelcomeViewController.self) { resolver, controller in
            controller.presenter = resolver.resolve(WelcomePresenting.self, arguments: controller as WelcomeDisplay, controller as WelcomeRouter)!
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        presenter.configureDisplay()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    // MARK: - WelcomeDisplay
    
    func setLoginButtonTitle(_ value: String) {
        loginButton.setTitle(value, for: .normal)
    }
    
    func setWelcomeTitle(_ value: String) {
        titleLabel.text = "Welcome"
    }
}

