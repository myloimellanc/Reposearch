//
//  Observable+reposearch.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/04/27.
//

import Foundation
import RxSwift


extension Observable {
    func mapToVoid() -> Observable<Void> {
        return self
            .map { _ in () }
    }
    
    func catchErrorJustComplete() -> Observable<Element> {
        return self.catch { _ in
            return .empty()
        }
    }
    
    func catchErrorAndComplete(_ handler: @escaping (Error) -> Void) -> Observable<Element> {
        self
            .do(onError: { handler($0) })
            .catchErrorJustComplete()
    }
}


extension Observable where Element == (HTTPURLResponse, Data) {
    func checkHttpError() -> Observable<Data> {
        return self.map { response, data -> Data in
            switch response.statusCode {
            case 200 ... 299:
                return data
                
            default:
                throw RSError.http(response.statusCode)
            }
        }
    }
}


extension PrimitiveSequence where Trait == SingleTrait {
    func mapToVoid() -> Single<Void> {
        return self
            .map { _ in () }
    }
}


extension PrimitiveSequence where Trait == SingleTrait, Element == Data {
    func decode<T: Codable>() -> Single<T> {
        return self
            .do(onSuccess: { data in
                DispatchQueue.global().async {
                    if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
                       let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
                       let prettyString = String(data: prettyData, encoding: .utf8) {
                        print(prettyString)
                    }
                }
            })
            .map { try JSONDecoder().decode(T.self, from: $0) }
    }
}
