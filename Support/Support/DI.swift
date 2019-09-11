
//  Copyright © 2019 Tom. All rights reserved.

import Foundation
import Swinject
/// Defines classes that manage a specific DependencyInjection container for an architectural layer within the app.
public protocol DependencyInjectionLayer {

    /// The Swinject container for this layer.
    static var dependencyInjectionContainer: Container! { get set }

    /// The list of classes this container will manage.
    static var managedClasses: [DependencyInjectionAware.Type] { get }

    /// Called to initialise the container.
    static func initialize(withParentContainer parentContainer: Container?)
}

// MARK: - Extensions

// Extension to define some of the functionality of DependencyInjectionLayer.
public extension DependencyInjectionLayer {

    static func initialize(withParentContainer parentContainer: Container? = nil) {
        dependencyInjectionContainer = Container(parent: parentContainer)
        managedClasses.forEach { $0.register(inContainer: self.dependencyInjectionContainer) }
    }
}

// MARK: - Managed classes

/**
 Defines methods used by classes which can be registered with the DependencyInjection framework.
 */
public protocol DependencyInjectionAware {

    /// Called during startup to register an instance of this class.
    ///
    /// - Parameter container: The container to register with.
    static func register(inContainer container: Container)
}

