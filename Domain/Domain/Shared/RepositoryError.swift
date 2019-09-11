
//  Copyright © 2019 Tom. All rights reserved.

/// Repository related errors.
public enum RepositoryError: Error {
    
    /// It appears that there may be a general network failure.
    case notConnectedToInternet
    
    /// The last request timed out.
    case timedOut
    
    /// General error.
    case general
}

