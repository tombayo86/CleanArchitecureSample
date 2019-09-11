
//  Copyright © 2019 Tom. All rights reserved.

import Foundation
import Swinject

public protocol AppPreferencesType: EndpointConfigurationRetrieving {
}

public protocol EndpointConfigurationRetrieving {
    var clientID: String { get }
    var clientSecret: String { get }
    
    func absoluteURL(forEndpoint endpoint: EndpointConfiguration) -> URL
}

/// Provides the endpoints that we want publicly accessible throughout the app.
public enum EndpointConfiguration {
    case login
    case logout
    
    static var all: [EndpointConfiguration] {
        return [
            login,
            logout
        ]
    }
}

/// AppPreferences is responsible for accessing various values, from UserDefaults in the future.
public struct AppPreferences: AppPreferencesType, DependencyInjectionAware {
    
    public var clientID: String {
        return retrieveEndpoints().clientID
    }
    
    public var clientSecret: String {
        return retrieveEndpoints().clientSecret
    }
    
    // MARK: - DependencyInjectionAware

    public static func register(inContainer container: Container) {
        container.register(AppPreferencesType.self) { _ in
            AppPreferences()
            }.inObjectScope(.container)
    }
    
    // MARK: - AppPreferencesProtocol
    
    /// Returns the url of the specified endpoint
    ///
    /// - Howto add another endpoint:
    ///   - Add the endpoint to the public enum `EndpointConfiguration` and the
    ///     end point dictionaries at the bottom of this file.
    ///
    /// - Parameters:
    ///   - endpoint: a case from the enum `EndpointConfiguration`.
    public func absoluteURL(forEndpoint endpoint: EndpointConfiguration) -> URL {
        let endpoints = retrieveEndpoints()
        return url(from: endpoints.urls[endpoint])
    }
    
    // MARK: - Private
    
    private func url(from urlString: String?) -> URL {
        guard let string: String = urlString, let url = URL(string: String(format: string)) else {
            fatalError("URL setting is invalid: \(String(describing: urlString))")
        }
        
        return url
    }
    
    private func retrieveEndpoints() -> Endpoints {
        return ProductionEndpoints()
    }
}

// MARK: - Endpoints Protocol

protocol Endpoints {
    var urls: [EndpointConfiguration: String] { get set }
    var clientID: String { get set }
    var clientSecret: String { get set }
}

struct ProductionEndpoints: Endpoints {
    
    private static let oauth: String = "https://accounts.spotify.com/"
    
    var urls: [EndpointConfiguration: String] = [
        .login: "\(ProductionEndpoints.oauth)/authorize",
        .logout: "\(ProductionEndpoints.oauth)/revoke",
    ]
    
    var clientID: String = "CLIENT_ID"
    var clientSecret: String = "CLIENT_SECRET"
}
