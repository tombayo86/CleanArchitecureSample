
//  Copyright © 2019 Tom. All rights reserved.

import DomainLayer
import RxSwift
import Support
import Swinject

protocol LoginPresenting: class {
    func configureDisplay()
    func login(email: String, password: String)
}

protocol LoginRouter: Router {}

protocol LoginDisplay: Display {
    func setTitle(_ text: String)
    func setEmailField(placeholder: String)
    func setPasswordField(placeholder: String)
    func setNextButtonTitle(_ text: String)
}

// MARK: - Implementation

final class LoginFormPresenter: LoginPresenting, DependencyInjectionAware {
    private weak var display: LoginDisplay!
    private weak var router: LoginRouter!
    private let disposeBag: DisposeBag = DisposeBag()
    
    var loginUseCase: PasswordLoginUseCase!
    
    static func register(inContainer container: Container) {
        container.register(LoginPresenting.self) { resolver, display, router in
            LoginFormPresenter(display: display,
                               router: router,
                               loginUseCase: resolver.resolve(PasswordLoginUseCase.self)!)
            }.inObjectScope(.transient)
    }
    
    // MARK: - Lifecycle
    
    init(display: LoginDisplay,
         router: LoginRouter,
         loginUseCase: PasswordLoginUseCase) {
        self.display = display
        self.router = router
        self.loginUseCase = loginUseCase
    }
    
    func configureDisplay() {
        display.setTitle("Hello, friend")
        display.setEmailField(placeholder: "e-mail")
        display.setPasswordField(placeholder: "password")
        display.setNextButtonTitle("Login")
    }
    
    func login(email: String, password: String) {
        loginUseCase.login(usingEmail: email, password: password)
            .subscribe(onCompleted: {
                print("logged in, move to next screen")
            }) { [weak self] (error) in
                self?.showError(error: error)
        }.disposed(by: disposeBag)
    }
    
    // MARK: - Internal
    
    private func showError(error: Error) {
        switch error {
        case AuthenticationError.loginFailed:
            showLoginAlert("Sorry dude, login failed")
        default:
            handleError(error)
        }
    }
    
    private func handleError(_ error: Error) {
        if let repositoryError = error as? RepositoryError {
            switch repositoryError {
            case .timedOut:
                showLoginAlert("Request timed out, try again later")
                return
            case .notConnectedToInternet:
                showLoginAlert("No connection to the internet, try again later")
                return
            default:
                // Fall through.
                break
            }
        }
        
        showGeneralError()
    }
    
    private func showLoginAlert(_ message: String) {
        display.showAlert(withTitle: "Login failed", message: message)
    }
    
    private func showGeneralError() {
        showLoginAlert("General error occured, try again later")
    }
}

