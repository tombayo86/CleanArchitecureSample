
// Copyright © 2017 Suncorp Pty Ltd. All rights reserved.

extension Bundle {
    static let current: Bundle = Bundle(for: PresentationAppDelegate.self)
    
    func displayName() -> String? {
        return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String
    }
}
