//
//  String+reposearch.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/05/02.
//

import Foundation


extension String {
    func utf8Base64Encoded() -> String? {
        return Data(self.utf8).base64EncodedString()
    }
    
    func utf8Base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
}
