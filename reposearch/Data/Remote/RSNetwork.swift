//
//  RSNetwork.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/26.
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire


let RSNetworkTimeoutInterval: TimeInterval = 10.0


typealias RSHTTPMethod = HTTPMethod
typealias RSURLConvertible = URLConvertible


fileprivate let RSNetworkScheduler = ConcurrentDispatchQueueScheduler(queue: DispatchQueue(label: "reposearch_network", attributes: .concurrent))


struct RSHTTPError: LocalizedError {
    let statusCode: Int
    
    var errorDescription: String? {
        return "HTTP Error occurred: \(self.statusCode)"
    }
}


extension Observable where Element == (HTTPURLResponse, Data) {
    func checkHttpError() -> Observable<Data> {
        return self.map { response, data -> Data in
            switch response.statusCode {
            case 200 ... 299:
                return data
                
            default:
                throw RSHTTPError(statusCode: response.statusCode)
            }
        }
    }
}


protocol RSNetworkInterface: AnyObject {
    func urlRequest(_ url: RSURLConvertible,
                    _ method: RSHTTPMethod,
                    parameters: Dictionary<String, Any>?,
                    headers: Dictionary<String, String>?) -> Single<Data>
}


struct RSNetworkFactory {
    static var instance: RSNetworkInterface {
        #if TEST
        return RSNetworkMockup()
        #else
        return RSNetwork.shared
        #endif
    }
    
    private init() {
        
    }
}


final class RSNetwork {
    static let shared = RSNetwork()
    
    private let session: Alamofire.Session
    
    private init() {
        let configuration: URLSessionConfiguration = .default
        configuration.headers = Alamofire.HTTPHeaders.default
        configuration.timeoutIntervalForRequest = RSNetworkTimeoutInterval
        
        let session = Alamofire.Session(configuration: configuration)
        self.session = session
    }
}


extension RSNetwork: RSNetworkInterface {
    func urlRequest(_ url: RSURLConvertible,
                    _ method: RSHTTPMethod,
                    parameters: Dictionary<String, Any>?,
                    headers: Dictionary<String, String>?) -> Single<Data> {
        var httpHeaders = HTTPHeaders()
        headers?.forEach {
            httpHeaders.add(name: $0, value: $1)
        }
        
        let encoding = URLEncoding.default
        return self.session.rx.request(method,
                                       url,
                                       parameters: parameters,
                                       encoding: encoding,
                                       headers: httpHeaders)
            .subscribe(on: RSNetworkScheduler)
            .responseData()
            .checkHttpError()
            .take(1)
            .asSingle()
    }
}
