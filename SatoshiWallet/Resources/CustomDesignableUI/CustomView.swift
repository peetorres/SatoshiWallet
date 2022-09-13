//
//  CustomView.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 09/09/22.
//

import UIKit

@IBDesignable
final class CustomView: UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
}
