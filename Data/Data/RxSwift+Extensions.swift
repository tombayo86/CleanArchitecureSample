
//  Copyright © 2019 Tom. All rights reserved.

import RxSwift

// MARK: - Singles

public extension PrimitiveSequence where Trait == SingleTrait {
    
    /**
     Fills in a gap where we want to call a Single and then execute a block before returning a Completable.
     
     - Parameter using: A block that takes the value of the Single as an argument and the Completable's completion
     block. This lets the using block complete the Completable with a success or error.
     - Parameter value: the value returned from the Single.
     - Parameter completable: An optional block that can be used to perform some task on the Single's value before completing.
     This also gives you the opportunity to return an error if you choose.
     - Parameter result: The Completable's result. Either `.completed` or `.error(_:Error)`.
     - Returns: A Completable.
     */
    func toCompletable(using: ((_ value: Element, _ completable: (_ result: CompletableEvent) -> Void) throws -> Void)? = nil) -> Completable {
        
        guard let using = using else {
            return asObservable().ignoreElements()
        }
        
        return Completable.create { completable in
            
            self.subscribe(
                onSuccess: { (element: Element) in
                    do {
                        // The block can either complete or fail the completable.
                        try using(element, completable)
                    } catch let error {
                        // Handles if the block throws an error.
                        completable(.error(error))
                    }
            },
                onError: { error in
                    // If the Single throws an error.
                    completable(.error(error))
            }
            )
        }
    }
}

// MARK: - Observables

public extension PrimitiveSequence {
    
    /**
     looks for errors returned from the current observable and if they are `APIError` instances, converts them to the matching domain error.
     - Returns: a instance of the same type as Self with the error converted or as is if not an `APIError`.
     */
    func mapErrorsToDomain() -> PrimitiveSequence<Trait, Element> {
        return catchError { error -> PrimitiveSequence<Trait, Element> in
            if let apiError = error as? APIError {
                throw apiError.asDomainError
            }
            throw error
        }
    }
}

