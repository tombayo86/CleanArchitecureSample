
//  Copyright © 2019 Tom. All rights reserved.

/// Authentication related errors.
public enum AuthenticationError: Error {
    
    /// The user is logged out and a call was made that expects them to be logged in.
    case userLoggedOut
    
    /// Login failed.
    case loginFailed
    
    /// Authentication failed. Most likely the user's authentication token has expired or the app's credentials are no longer valid.
    case authenticationFailed
    
    /// The user refresh token has expired
    case userSessionExpired
}
