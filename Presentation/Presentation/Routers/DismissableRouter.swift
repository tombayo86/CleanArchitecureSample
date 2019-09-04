
//  Copyright © 2019 Tom. All rights reserved.

import UIKit

public protocol DismissableRouter: class {
    
    func dismiss()
    
    func dismiss(completion: (() -> Void)?)
}

public extension DismissableRouter where Self: UIViewController {
    
    func dismiss() {
        dismiss(completion: nil)
    }
    
    func dismiss(completion: (() -> Void)?) {
        view.endEditing(true)
        dismiss(animated: true, completion: completion)
    }
}
