
//  Copyright © 2019 Tom. All rights reserved.

import Swinject

class BaseLoginUseCaseImplementation {
    
    let loginRepository: LoginRepository
    
    required init(resolver: Resolver) {
        self.loginRepository = resolver.resolve(LoginRepository.self)!
    }
}

