
//  Copyright © 2019 Tom. All rights reserved.

import RxSwift
import Swinject

/// Describes a use case for logging in using an email and password.
public protocol PasswordLoginUseCase: UseCase {
    /**
     Performs a login using an email and password.
     - Parameters:
     - email: The user's email address.
     - password: The user's password.
     - Returns: `Completable` instance.
     */
    @discardableResult func login(usingEmail email: String, password: String) -> Completable
}

final class PasswordLoginUseCaseImplementation: BaseLoginUseCaseImplementation, PasswordLoginUseCase {
    
    // MARK: - DependencyInjectionAware

    public static func register(inContainer container: Container) {
        container.register(PasswordLoginUseCase.self) { resolver in
            PasswordLoginUseCaseImplementation(resolver: resolver)
            }.inObjectScope(.weak)
    }
    
    @discardableResult func login(usingEmail email: String, password: String) -> Completable {
        return loginRepository.login(username: email, password: password)
    }
}
