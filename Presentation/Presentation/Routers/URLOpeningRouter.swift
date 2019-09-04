
//  Copyright © 2019 Tom. All rights reserved.

import Foundation
/**
 Protocol which defines methods we are interested in overridden during tests.
 
 To use it we just extend UIApplication with it. In tests we can then mock out the protocol rather than using UIApplication directly.
 
 */
public protocol UIApplicationProtocol {
    func open(_ url: URL, options: [String: Any], completionHandler completion: ((Bool) -> Void)?)
}

extension UIApplication: UIApplicationProtocol {
    public func open(_ url: URL, options: [String : Any], completionHandler completion: ((Bool) -> Void)?) {}
}

/// Router which provides services for opening URLs.
public protocol URLOpeningRouter: class {
    
    /// Gets the application object for opening the url.
    var application: UIApplicationProtocol { get }
    
    /**
     Open the requested url.
     
     This is a facade for `UIApplication.shared.open(_:_:_:)` and provides the url and completion handler arguments to that call.
     
     - Parameter url: the URL to open.
     */
    func open(url: URL)
    
    /**
     Open the requested url.
     
     This is a facade for `UIApplication.shared.open(_:_:_:)` and provides the url and completion handler arguments to that call.
     
     - Parameter url: the URL to open.
     - Parameter completionHandler: A closure to execute once the URL has been opened.
     Note that this is executed when the URL is opened, not after any subsequent display is closed.
     */
    func open(url: URL, completionHandler: ((Bool) -> Void)?)
}

public extension URLOpeningRouter {
    
    var application: UIApplicationProtocol {
        return UIApplication.shared
    }
    
    func open(url: URL) {
        open(url: url, completionHandler: nil)
    }
    
    func open(url: URL, completionHandler: ((Bool) -> Void)?) {
        application.open(url, options: [:], completionHandler: completionHandler)
    }
}
