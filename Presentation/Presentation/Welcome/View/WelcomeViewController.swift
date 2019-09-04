
//  Copyright © 2019 Tom. All rights reserved.

import Support
import UIKit

final class WelcomeViewController: UIViewController, WelcomeRouter, WelcomeDisplay, PresenterSource {
    
    @IBOutlet weak var loginButton: UIButton!
    
    var presenter: WelcomePresenting!
    //    private var windowRouter: WindowRouter!
    
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
    
//    @IBAction func unwindToWelcomeScreen(_: UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        if segue.identifier == WelcomeSegueIdentifier.welcomeToLogin.rawValue,
        //            let navigationController: UINavigationController = segue.destination as? UINavigationController,
        //            let loginViewController: LoginViewController = navigationController.viewControllers.first as? LoginViewController {
        //            presenter.prepareForPresentation(of: loginViewController.presenter)
        //        }
    }
    
    // MARK: - WelcomeDisplay
    
    func setLoginButtonTitle(_ value: String) {
        loginButton.setTitle(value, for: .normal)
    }
    
    // MARK: - Resettable
    
    func reset() {
        dismiss(animated: false)
    }
}

