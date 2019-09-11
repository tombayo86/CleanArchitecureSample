
//  Copyright © 2019 Tom. All rights reserved.

import DomainLayer
import Support

protocol AuthenticatedRequest {
    func withAuthorization(endpointConfiguration: EndpointConfigurationRetrieving) throws -> URLRequest
}

protocol ClientAuthentication: AuthenticatedRequest {}

extension ClientAuthentication where Self: BaseRequest {
    
    func withAuthorization(endpointConfiguration: EndpointConfigurationRetrieving) throws -> URLRequest {
        return try withClientAuthorization(clientID: endpointConfiguration.clientID, clientSecret: endpointConfiguration.clientSecret)
    }
}

extension BaseRequest {
    func withClientAuthorization(clientID: String, clientSecret: String) throws -> URLRequest {
        
        var authenticatedRequest: URLRequest = urlRequest
        
        let credentialsContent: String = String(format: "%@:%@", clientID, clientSecret)
        let credentials: Data = credentialsContent.data(using: String.Encoding.utf8)!
        
        let requestValue: String = "Basic \(credentials.base64EncodedString())"
        authenticatedRequest.addValue(requestValue, forHTTPHeaderField: "Authorization")
        
        return authenticatedRequest
    }
}
