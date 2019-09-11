
//  Copyright © 2019 Tom. All rights reserved.

import Support

extension Decodable {
    
    /// Reads the JSON from the passed data and creates an instance of this type.
    ///
    /// - Parameter jsonData: A Data object containing the JSON to read.
    /// - Returns: An instance of this class.
    /// - Throws: An error if the JSON data could not be read.
    static func decode(fromJSONData jsonData: Data) throws -> Self {
        return try JSONDecoder().decode(self, from: jsonData) as Self
    }
}

