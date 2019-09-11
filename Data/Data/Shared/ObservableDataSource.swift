
//  Copyright © 2019 Tom. All rights reserved.

/// Data tasks which address a server and optionally return a Data instance.
protocol ObservableDataSource {
    
    /**
     Calls the server and returns a `Completable`.
     
     This task addresses API which do not return data. If the API does return some data, it will be ignored.
     This can also be used when we don't care about the result. Response body will still be checked for server errors.
     
     - Parameter request: A BaseRequest instance that defines the API call.
     - Returns a `Completable` instance.
     */
    @discardableResult func completableDataTask(with request: BaseRequest) -> Completable
    
    /**
     Calls the server and returns a `Single<Data>` instance.
     
     This task addresses APIs which return data. If the API does not return data, a `RepositoryError.noDataReturned` error will be returned.
     The response body will also be checked for errors from the server.
     
     - Parameter request: A BaseRequest instance that defines the API call.
     - Parameter T: The expected type for converting the JSON response body into.
     - Returns: a `Single<T>` instance containing the data returned from the API call.
     */
    @discardableResult func singleDataTask<T>(with request: BaseRequest) -> Single<T> where T: Decodable
}

import Foundation
import RxSwift

