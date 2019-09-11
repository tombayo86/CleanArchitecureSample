
//  Copyright © 2019 Tom. All rights reserved.

import Foundation
import RxSwift
import Support
import Swinject

extension URLSession: DependencyInjectionAware {

    public static func register(inContainer container: Container) {
        container.register(URLSession.self) { _ in
            let sessionConfiguration = URLSessionConfiguration.default
            sessionConfiguration.tlsMinimumSupportedProtocol = .tlsProtocol12
            sessionConfiguration.timeoutIntervalForRequest = 30
            return URLSession(configuration: sessionConfiguration)
        }
    }
}


final class HTTPClient: ObservableDataSource, DependencyInjectionAware {
    
    let session: URLSession
    let tokenStore: TokenStore
    let endpointConfiguration: EndpointConfigurationRetrieving
    
    // MARK: - DependencyInjectionAware

    static func register(inContainer container: Container) {
        container.register(ObservableDataSource.self) { resolver in
            HTTPClient(
                session: resolver.resolve(URLSession.self)!,
                tokenStore: resolver.resolve(TokenStore.self)!,
                endpointConfiguration: resolver.resolve(AppPreferencesType.self)!
            )
            }.inObjectScope(.container)
    }
    
    init(
        session: URLSession,
        tokenStore: TokenStore,
        endpointConfiguration: EndpointConfigurationRetrieving
        ) {
        self.session = session
        self.tokenStore = tokenStore
        self.endpointConfiguration = endpointConfiguration
    }
    
    // MARK: - ObservableDataSource
    
    @discardableResult func completableDataTask(with request: BaseRequest) -> Completable {
        
        // Return a completable that wraps a request where we don't care about the result or where the API does not return a response body.
        // The only difference between this and the custom `toCompletable()` extension is that this looks for no data errors and treats them as a success.
        struct NoData: Codable {}
        
        return (singleDataTask(with: request) as Single<NoData>)
            .toCompletable()
            .catchError { error in
                if case APIError.noDataReturned = error {
                    return Completable.empty()
                }
                return Completable.error(error)
        }
    }
    
    @discardableResult func singleDataTask<T>(with request: BaseRequest) -> Single<T> where T: Decodable {
        return Single<T>.create { single in
            
            guard var urlRequest = self.buildURLRequest(from: request, single: single) else {
                return Disposables.create()
            }
            
            // Disable all URL request caching
            urlRequest.cachePolicy = .reloadIgnoringLocalAndRemoteCacheData
            
            let urlSession: URLSession = self.session
            
            let task = urlSession.dataTask(with: urlRequest) { data, response, error in
                self.handleTaskResult(with: data, response: response, error: error, single: single)
            }
            
            task.resume()
            
            return Disposables.create(with: task.cancel)
        }
    }
    
    // MARK: - Private methods
    
    private func buildURLRequest<T>(from request: BaseRequest, single: @escaping (SingleEvent<T>) -> Void) -> URLRequest? where T: Decodable {
        
        do {
            if let authenticatedRequest = request as? AuthenticatedRequest {
                return try authenticatedRequest.withAuthorization(endpointConfiguration: endpointConfiguration)
            } else {
                return request.urlRequest
            }
        } catch let error {
            single(.error(error))
            return nil
        }
    }
    
    private func handleTaskResult<T>(with data: Data?, response: URLResponse?, error: Error?, single: @escaping (SingleEvent<T>) -> Void) where T: Decodable {
        if let error = error {
            handleTaskError(error: error, single: single)
        } else {
            handleTaskResponse(response, data: data, single: single)
        }
    }
    
    private func handleTaskError<T>(error: Error, single: @escaping (SingleEvent<T>) -> Void) where T: Decodable {
        
        let networkError: NSError = error as NSError
        
        switch networkError.code {
            
        case NSURLErrorNotConnectedToInternet:
            single(.error(APIError.networkFailure))
            
        case NSURLErrorTimedOut:
            single(.error(APIError.timeout))
            
        default:
            single(.error(APIError.unexpectedError(networkError)))
        }
    }
    
    private func handleTaskResponse<T>(_ response: URLResponse?, data: Data?, single: @escaping (SingleEvent<T>) -> Void) where T: Decodable {
        
        guard let response = response as? HTTPURLResponse else {
            single(.error(APIError.unexpectedResponseType))
            return
        }
        
        // Decode errors that could potentially be returned as part of the HTTP response.
        if let errors = decodeServerErrors(from: data) {
            single(.error(APIError.serverError(status: response.statusCode, errors: errors)))
            return
        }
        
        let httpSuccessCode: Range<Int> = 200 ..< 300
        
        // Check if response code is within the success/200 range.
        if httpSuccessCode.contains(response.statusCode) {
            // attempt to decode response
            if let data = data, !data.isEmpty {
                decodeResponse(data: data, single: single)
            } else {
                single(.error(APIError.noDataReturned))
            }
            
            return
        }
        
        // Check if the response code is supposed to be handled
        guard let errorCode: HTTPErrorCode = HTTPErrorCode(rawValue: response.statusCode) else {
            let error: Error = APIError.serverError(status: response.statusCode, errors: nil)
            single(.error(error))
            return
        }
        
        // handle error code appropriately
        switch errorCode {
        case .forbidden:
            single(.error(APIError.authenticationFailed))
            
        case .notFound:
            single(.error(APIError.notFound))
        }
    }
    
    private func decodeResponse<T>(data: Data, single: @escaping (SingleEvent<T>) -> Void) where T: Decodable {
        do {
            let values = try T.decode(fromJSONData: data)
            single(.success(values))
        } catch {
            single(.error(APIError.conversionError))
        }
    }
    
    private func decodeServerErrors(from data: Data?) -> [ServerError]? {
        return data
            .flatMap { try? ServerErrors.decode(fromJSONData: $0) }?
            .errors
    }
}

enum HTTPErrorCode: Int {
    // Client errors
    case forbidden = 403
    case notFound = 404
}
