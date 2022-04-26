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
        return .just(Data())
    }
}
