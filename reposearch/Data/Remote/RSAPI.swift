//
//  RSAPI.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/26.
//

import Foundation
import RxSwift


extension PrimitiveSequence where Trait == SingleTrait, Element == Data {
    func decode<T: Codable>() -> Single<T> {
        return self
            .map { try JSONDecoder().decode(T.self, from: $0) }
    }
}


enum RSAPIURL: String, CaseIterable {
    
    case searchReposiroties = "/search/repositories"
    
    var method: RSHTTPMethod {
        switch self {
        case .searchReposiroties:
            return .get
        }
    }
    
    var baseURL: String {
        return "https://api.github.com"
    }
    
    var url: String {
        return self.baseURL.appending(self.rawValue)
    }
}


protocol RSAPIInterface {
    func searchRepositories(text: String) -> Single<SearchRepositoriesResponse>
}


struct RSAPIFactory {
    static var instance: RSAPIInterface {
        #if TEST
        return RSAPIMockup()
        #else
        return RSAPI()
        #endif
    }
    
    private init() {
        
    }
}


struct RSAPI: RSAPIInterface {
    func searchRepositories(text: String) -> Single<SearchRepositoriesResponse> {
        let apiUrl = RSAPIURL.searchReposiroties
        return RSNetworkFactory.instance.urlRequest(apiUrl.url, apiUrl.method, parameters: ["q": text], headers: nil)
            .decode()
    }
}
