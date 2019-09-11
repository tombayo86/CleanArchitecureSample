
//  Copyright © 2019 Tom. All rights reserved.

import Foundation
import Support
import Swinject

final class TokenStore: DependencyInjectionAware {
    
    static func register(inContainer container: Container) {
        container.register(TokenStore.self) { _ in
            TokenStore()
            }.inObjectScope(.container)
    }
    
    // Used for standard authenticated requests for the app flow
    var accessToken: String?
    var refreshToken: String?
    
    func set(token: Token) {
        accessToken = token.accessToken
        refreshToken = token.refreshToken
    }
    
    func clearTokens() {
        accessToken = nil
        refreshToken = nil
    }
}

