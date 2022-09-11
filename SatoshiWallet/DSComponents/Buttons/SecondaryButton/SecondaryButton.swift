//
//  PrimaryButton.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 11/09/22.
//

import UIKit

@IBDesignable
final class SecondaryButton: UIView, LoadableView {
    // MARK: Properties
    internal var contentView: UIView?

    @IBInspectable public var title: String = "" {
        didSet {
            button.setTitle(title, for: .normal)
            setupUI()
        }
    }

    public var handlerButton: (() -> Void)?

    // MARK: Outlets
    @IBOutlet weak var button: UIButton!

    // MARK: Overrides
    override init(frame: CGRect) {
        super.init(frame: frame)
        defaultSetup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        defaultSetup()
    }

    // MARK: Actions
    @IBAction private func handlerButton(_ sender: Any) {
        handlerButton?()
    }

    // MARK: Methods
    private func setupUI() {
        button.setupTouchEventsHandler()
    }
}
