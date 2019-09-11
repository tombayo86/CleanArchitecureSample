
//  Copyright © 2019 Tom. All rights reserved.

public struct User {
    
    public let userID: String
    public let username: String
    public let email: String
    
    public init(
        userID: String,
        username: String,
        email: String
        ) {
        self.userID = userID
        self.username = username
        self.email = email
    }
}

