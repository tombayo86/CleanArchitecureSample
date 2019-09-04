
//  Copyright © 2019 Tom. All rights reserved.

import Foundation

/**
 Protocol which allows us to define the presenter variable in a class as a specific type
 and access it within generic routines.
 
 As a general rule, if you implement this protocol you only need to declare
 ```swift
 var presenter: MyPresenter!
 ```
 
 Swift can infer the correct associated type from that.
 */
public protocol PresenterSource: class {
    
    /// The type of the presenter.
    associatedtype PresenterType
    
    /// Reference to the presenter.
    var presenter: PresenterType! { get }
}

