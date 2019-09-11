
//  Copyright © 2019 Tom. All rights reserved.

import Foundation
import RxSwift

/// Repository of login information.
public protocol LoginRepository {
    
    /**
     Logs in a user.
     
     - Parameter username: the user's username. Usually this is their email address.
     - Parameter password: The user's password.
     */
    func login(username: String, password: String) -> Completable

    /**
     Logs the current user out.
     
     */
    func logout() -> Completable
}

