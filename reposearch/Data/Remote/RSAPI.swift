//
//  RSAPI.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/26.
//

import Foundation
import RxSwift


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
    func searchRepositories(query: String,
                            sort: RSSearchSort,
                            order: RSSearchOrder,
                            perPage: Int64,
                            page: Int64) -> Single<SearchRepositoriesResponse>
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
    func searchRepositories(query: String,
                            sort: RSSearchSort,
                            order: RSSearchOrder,
                            perPage: Int64,
                            page: Int64) -> Single<SearchRepositoriesResponse> {
        let headers: Dictionary<String, String> = [
            "accept": "application/vnd.github.v3+json"
        ]
        
        let apiUrl = RSAPIURL.searchReposiroties
        var url = apiUrl.url
        
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            return .error(RSError.default("Query encode failed"))
        }
        
        url.append("?q=\(encodedQuery)")
        
        if let sortParameter = sort.parameterValue {
            url.append("&sort=\(sortParameter)&order=\(order.parameterValue)")
        }
        
        url.append("&per_page=\(perPage)&page=\(page)")
        
        return RSNetworkFactory.instance.urlRequest(url, apiUrl.method, parameters: nil, headers: headers)
            .decode()
        
        
        // TODO: Alamofire의 URLEncoded Request 요청에 패러미터가 정상적으로 포함되지 않는 문제 수정 필요
//        let parameters: Dictionary<String, Any> = [
//            "q": query,
//            "sort": sort.parameterValue as Any,
//            "order": order.parameterValue,
//            "per_page": perPage,
//            "page": page
//        ]
        
//        return RSNetworkFactory.instance.urlRequest(apiUrl.url, apiUrl.method, parameters: parameters, headers: headers)
    }
}
