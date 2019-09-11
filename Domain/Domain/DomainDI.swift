
//  Copyright © 2019 Tom. All rights reserved.

import Foundation
import Support
import Swinject

public final class DomainDependencyInjection: DependencyInjectionLayer {
    public static var dependencyInjectionContainer: Container!
    
    public static var managedClasses: [DependencyInjectionAware.Type] {
        return [
            PasswordLoginUseCaseImplementation.self
        ]
    }
}

