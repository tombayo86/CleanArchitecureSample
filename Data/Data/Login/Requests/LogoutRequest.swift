
//  Copyright © 2019 Tom. All rights reserved.

import Foundation

final class LogoutRequest: BaseRequest, ClientAuthentication {
    var urlRequest: URLRequest
    
    init(url: URL, accessToken: String) {
        urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPRequestMethod.post.rawValue
        
        let httpBodyMessage: String = "token=\(accessToken)&token_type_hint=access_token"
        let httpBody: Data? = httpBodyMessage.data(using: .utf8)
        
        urlRequest.httpBody = httpBody
        urlRequest.allHTTPHeaderFields = ["Content-Type": "application/x-www-form-urlencoded"]
    }
}
