
//  Copyright © 2019 Tom. All rights reserved.

import Foundation
import Support
import Swinject

public final class DataDependencyInjection: DependencyInjectionLayer {
    
    public static var dependencyInjectionContainer: Container!
    
    public static var managedClasses: [DependencyInjectionAware.Type] {
        return [
            AppPreferences.self,
            LoginService.self,
            HTTPClient.self,
            URLSession.self,
            TokenStore.self
        ]
    }
}

