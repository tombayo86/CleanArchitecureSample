
//  Copyright © 2019 Tom. All rights reserved.

import UIKit

public protocol PerformSegueRouter: class {
    
    func performSegue(withIdentifier identifier: String)
}

public extension PerformSegueRouter where Self: UIViewController {
    
    func performSegue(withIdentifier identifier: String) {
        performSegue(withIdentifier: identifier, sender: self)
    }
}
