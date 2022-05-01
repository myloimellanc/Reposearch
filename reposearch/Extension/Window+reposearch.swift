//
//  Window+reposearch.swift
//  reposearch
//
//  Created by mellancmyloi on 2022/05/01.
//

import UIKit
import Toast_Swift


extension UIWindow {
    static func initToastStyle() {
        var toastStyle = ToastStyle()
        toastStyle.backgroundColor = R.color.surfaceGrey()!
        toastStyle.messageColor = R.color.textWhite()!
        toastStyle.messageFont = .systemFont(ofSize: 15.0)
        toastStyle.horizontalPadding = 16.0
        toastStyle.verticalPadding = 16.0
        toastStyle.cornerRadius = 16.0
        
        ToastManager.shared.isTapToDismissEnabled = true
        ToastManager.shared.duration = ToastManager.shared.duration
        ToastManager.shared.style = toastStyle
    }
    
    func getMaxWidthToastStyle() -> ToastStyle {
        var toastStyle = ToastManager.shared.style
        
        let horizontalPaddingSum: CGFloat = 15.0 * 2
        toastStyle.maxWidthPercentage = (self.bounds.width - horizontalPaddingSum) / self.bounds.width
        toastStyle.alwaysOnMaxWidth = true
        
        return toastStyle
    }
    
    func addToast(_ message: String) {
        self.hideAllToasts(includeActivity: true,
                           clearQueue: true)
        
        let toastStype = self.getMaxWidthToastStyle()
        self.makeToast(message,
                       position: .bottom,
                       style: toastStype)
    }
}
