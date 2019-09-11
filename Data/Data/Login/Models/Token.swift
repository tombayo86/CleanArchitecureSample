
//  Copyright © 2019 Tom. All rights reserved.

import Foundation

struct Token: Codable {
    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case scope
        case refreshToken = "refresh_token"
        case accessToken = "access_token"
        case expiresIn = "expires_in"
    }
    
    let tokenType: String
    let scope: String
    let refreshToken: String
    let accessToken: String
    let expiresIn: Int
}

