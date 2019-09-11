
//  Copyright © 2019 Tom. All rights reserved.

extension Bundle {
    static let current: Bundle = Bundle(for: PresentationAppDelegate.self)
    
    func displayName() -> String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
}
