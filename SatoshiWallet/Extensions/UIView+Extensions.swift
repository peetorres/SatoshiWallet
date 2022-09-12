//
//  UIView+Extensions.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 11/09/22.
//

import UIKit

public extension UIView {
    class func fromNib(named: String? = nil) -> Self {
        let name = named ?? "\(Self.self)"
        guard let nib = Bundle.main.loadNibNamed(name, owner: nil, options: nil) else {
            fatalError("Missing expected nib named: \(name)")
        }
        guard let view = nib.first as? Self else {
            fatalError("View of type \(Self.self) not found in \(nib)")
        }
        return view
    }

    func fadeIn(duration: TimeInterval = 1.0, alpha: CGFloat = 1.0) {
        UIView.animate(withDuration: duration) { [weak self] in
            self?.alpha = alpha
        }
    }

    func fadeOut(duration: TimeInterval = 1.0, alpha: CGFloat = 0.0) {
        UIView.animate(withDuration: duration) { [weak self] in
            self?.alpha = alpha
        }
    }
}
