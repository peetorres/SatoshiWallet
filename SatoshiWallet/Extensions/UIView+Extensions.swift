//
//  UIView+Extensions.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 11/09/22.
//

import UIKit

public extension UIView {
    func fadeIn(duration: TimeInterval = 1.0, alpha: CGFloat = 1.0) {
        UIView.animate(withDuration: duration) {
            self.alpha = alpha
        }
    }

    func fadeOut(duration: TimeInterval = 1.0, alpha: CGFloat = 0.0) {
        UIView.animate(withDuration: duration) {
            self.alpha = alpha
        }
    }
}
