//
//  AttributedString+reposearch.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/05/01.
//

import UIKit


extension Dictionary where Key == NSAttributedString.Key, Value == Any {
    static func RSTextAttributes(_ base: Dictionary<NSAttributedString.Key, Any>,
                                 with additional: Dictionary<NSAttributedString.Key, Any> = [:],
                                 into alignment: NSTextAlignment = .natural) -> Dictionary<NSAttributedString.Key, Any> {
        var modified = base
        additional.forEach { modified[$0] = $1 }
        
        if let paragraphStyle = modified[.paragraphStyle] as? NSParagraphStyle,
           let mutableParagraphStyle = paragraphStyle.mutableCopy() as? NSMutableParagraphStyle {
            mutableParagraphStyle.alignment = alignment
            modified[.paragraphStyle] = mutableParagraphStyle
        }
        
        return modified
    }
    
    /// Bold font with size 34
    static var Signature: Dictionary<NSAttributedString.Key, Any> {
        let attributes: Dictionary<NSAttributedString.Key, Any> = [
            .font: UIFont.systemFont(ofSize: 34.0, weight: .bold),
            .foregroundColor: R.color.textBlack() as Any,
        ]
        
        return attributes
    }
    
    /// Semi bold font with size 17
    static var H4: Dictionary<NSAttributedString.Key, Any> {
        let attributes: Dictionary<NSAttributedString.Key, Any> = [
            .font: UIFont.systemFont(ofSize: 17.0, weight: .semibold),
            .foregroundColor: R.color.textBlack() as Any
        ]
        
        return attributes
    }
    
    /// Regular font with size 17
    static var Body1: Dictionary<NSAttributedString.Key, Any> {
        let attributes: Dictionary<NSAttributedString.Key, Any> = [
            .font: UIFont.systemFont(ofSize: 17.0, weight: .regular),
            .foregroundColor: R.color.textBlack() as Any
        ]
        
        return attributes
    }
    
    /// Regular font with size 15
    static var Body2: Dictionary<NSAttributedString.Key, Any> {
        let attributes: Dictionary<NSAttributedString.Key, Any> = [
            .font: UIFont.systemFont(ofSize: 15.0, weight: .regular),
            .foregroundColor: R.color.textBlack() as Any
        ]
        
        return attributes
    }
}


extension NSAttributedString {
    /// Bold font with size 34
    static func Signature(_ text: String, with additionalStyle: Dictionary<NSAttributedString.Key, Any>? = nil, into alignment: NSTextAlignment = .natural) -> NSAttributedString {
        return NSAttributedString(string: text, attributes: .RSTextAttributes(.Signature, with: additionalStyle ?? [:], into: alignment))
    }
    
    /// Semi bold font with size 17
    static func H4(_ text: String, with additionalStyle: Dictionary<NSAttributedString.Key, Any>? = nil, into alignment: NSTextAlignment = .natural) -> NSAttributedString {
        return NSAttributedString(string: text, attributes: .RSTextAttributes(.H4, with: additionalStyle ?? [:], into: alignment))
    }
    
    /// Regular font with size 17
    static func Body1(_ text: String, with additionalStyle: Dictionary<NSAttributedString.Key, Any>? = nil, into alignment: NSTextAlignment = .natural) -> NSAttributedString {
        return NSAttributedString(string: text, attributes: .RSTextAttributes(.Body1, with: additionalStyle ?? [:], into: alignment))
    }
    
    /// Regular font with size 15
    static func Body2(_ text: String, with additionalStyle: Dictionary<NSAttributedString.Key, Any>? = nil, into alignment: NSTextAlignment = .natural) -> NSAttributedString {
        return NSAttributedString(string: text, attributes: .RSTextAttributes(.Body2, with: additionalStyle ?? [:], into: alignment))
    }
}
