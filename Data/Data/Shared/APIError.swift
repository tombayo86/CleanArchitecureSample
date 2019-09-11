
//  Copyright © 2019 Tom. All rights reserved.

import DomainLayer

/// API errors from servers. These should never appear in the Domain or UI layers.
enum APIError: Error {
    
    /// A general network failure.
    case networkFailure
    
    /// The request timed out.
    case timeout
    
    /// The requests authentication data was rejected.
    case authenticationFailed
    
    /// USer authentication was require, but no token was found in the store.
    case userLoggedOut
    
    /// The requested URL was not found on the server.
    case notFound
    
    /// There was a problem converting JSON payloads either to or from a type.
    case conversionError
    
    /// A call was made for data, but none was returned in the response body.
    case noDataReturned
    
    /// The response was not a HTTP response.
    case unexpectedResponseType
    
    /// The user refresh token has expired
    case userSessionExpired
    
    /// Server errors where detected. Errors contains any errors found in the response body.
    case serverError(status: Int, errors: [ServerError]?)
    
    /// Something completetly unexpected occured.
    case unexpectedError(Error)
}

/// Used to read JSON error data from server responses.
struct ServerErrors: Codable {
    let errors: [ServerError]
}

/// Actual server errors.
struct ServerError: Codable {
    let status: String
    let code: String
    
    /// User-readable (localized) error title (if available)
    let title: String?
    
    /// User-readable (localized) error detail message (if available)
    let detail: String?
}

extension APIError {
    
    /// Maps a server API error to a Domain layer error.
    var asDomainError: Error {
    
        switch self {
        case .networkFailure:
            return RepositoryError.notConnectedToInternet

        case .userLoggedOut:
            return AuthenticationError.userLoggedOut

        case .timeout:
            return RepositoryError.timedOut

        case .authenticationFailed:
            return AuthenticationError.authenticationFailed

        case .userSessionExpired:
            return AuthenticationError.userSessionExpired

        case .unexpectedResponseType:
            return RepositoryError.general

        case .serverError(HTTPErrorCode.forbidden.rawValue, _):
            return AuthenticationError.authenticationFailed

        case .serverError:
            return RepositoryError.general

        default:
            return RepositoryError.general
        }
    }
}

