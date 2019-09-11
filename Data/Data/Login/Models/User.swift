
//  Copyright © 2019 Tom. All rights reserved.

struct User: Codable {
    let username: String
    let email: String?
    
    private enum CodingKeys: String, CodingKey {
        case username
        case email
    }
}
