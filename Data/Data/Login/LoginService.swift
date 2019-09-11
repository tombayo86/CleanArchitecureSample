
//  Copyright © 2019 Tom. All rights reserved.

import DomainLayer
import Foundation
import RxSwift
import Support
import Swinject

final class LoginService: LoginRepository, DependencyInjectionAware {
    
    let tokenStore: TokenStore
    let dataSource: ObservableDataSource
    let endpointConfiguration: EndpointConfigurationRetrieving
    
    // MARK: - DependencyInjectionAware

    static func register(inContainer container: Container) {
        container.register(LoginRepository.self) { resolver in
            LoginService(
                dataSource: resolver.resolve(ObservableDataSource.self)!,
                endpointConfiguration: resolver.resolve(AppPreferencesType.self)!,
                tokenStore: resolver.resolve(TokenStore.self)!
            )
            }.inObjectScope(.container)
    }
    
    // MARK: - Lifecycle
    
    init(dataSource: ObservableDataSource,
         endpointConfiguration: EndpointConfigurationRetrieving,
         tokenStore: TokenStore) {
        self.dataSource = dataSource
        self.endpointConfiguration = endpointConfiguration
        self.tokenStore = tokenStore
    }
    
    // MARK: - Tasks
    
    public func login(username: String, password: String) -> Completable {
        let request = LoginRequest(url: endpointConfiguration.absoluteURL(forEndpoint: .login), username: username, password: password)
        return (dataSource.singleDataTask(with: request) as Single<Token>)
            
            // Look for login failure errors.
            .catchError { error in
                switch error {
                case let APIError.serverError(status, _) where status == 401:
                    throw AuthenticationError.loginFailed
                default:
                    throw error
                }
            }
            
            // Store the tokens.
            .map { token in
                self.tokenStore.set(token: token)
            }
            .toCompletable()
            .mapErrorsToDomain()
            .observeOn(MainScheduler.instance)
    }
    
    public func logout() -> Completable {
        
        guard let accessToken: String = tokenStore.accessToken else {
            tokenStore.clearTokens()
            return Completable.empty()
        }
        
        let request = LogoutRequest(url: endpointConfiguration.absoluteURL(forEndpoint: .logout), accessToken: accessToken)
        tokenStore.clearTokens()
        
        return dataSource.completableDataTask(with: request)
            .mapErrorsToDomain()
            .observeOn(MainScheduler.instance)
    }
    
    // MARK: - Private methods
    
    private func completableDataTaskForPinRequest(_ request: BaseRequest) -> Completable {
        return dataSource.completableDataTask(with: request)
            .mapErrorsToDomain()
            .observeOn(MainScheduler.instance)
    }
}

