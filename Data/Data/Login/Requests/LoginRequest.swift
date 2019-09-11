
//  Copyright © 2019 Tom. All rights reserved.

import Foundation

final class LoginRequest: BaseRequest, ClientAuthentication {
    var urlRequest: URLRequest
    
    init(url: URL, username: String, password: String) {
        urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = HTTPRequestMethod.post.rawValue
        
        let httpBodyContent: String = "grant_type=password&username=\(username)&password=\(password)&scope="
        let httpBody: Data? = httpBodyContent.data(using: .utf8)
        
        urlRequest.httpBody = httpBody
        urlRequest.allHTTPHeaderFields = ["Content-Type": "application/x-www-form-urlencoded"]
    }
}
