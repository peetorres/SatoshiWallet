//
//  LoadableView.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 11/09/22.
//

import UIKit

public protocol LoadableView: UIView {
    var contentView: UIView? { get set }
    func defaultSetup()
}

extension LoadableView {
    public func defaultSetup() {
        let nibName = String(describing: Self.self)
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName, bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as? UIView

        if let view = nibView {
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(view)
            contentView = view
        }
    }
}
