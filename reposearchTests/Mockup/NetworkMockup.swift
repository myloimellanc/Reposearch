//
//  NetworkMockup.swift
//  reposearchTests
//
//  Created by mellancmyloi on 2022/04/26.
//

import Foundation
import RxSwift


final class RSNetworkMockup {
    
}


extension RSNetworkMockup: RSNetworkInterface {
    func urlRequest(_ url: RSURLConvertible, _ method: RSHTTPMethod, parameters: Dictionary<String, Any>?, headers: Dictionary<String, String>?) -> Single<Data> {
        for apiURL in RSAPIURL.allCases {
            if url as? String == apiURL.url, let responseMockup = apiURL.responseMockup(method: method) {
                return .just(responseMockup)
            }
        }
        
        return .error(RSHTTPError.init(statusCode: 500))
    }
}
