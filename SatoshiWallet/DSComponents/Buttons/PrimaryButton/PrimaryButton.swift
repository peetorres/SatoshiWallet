//
//  PrimaryButton.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 11/09/22.
//

import UIKit

@IBDesignable
final class PrimaryButton: UIView, LoadableView {
    // MARK: Properties
    internal enum ButtonType {
        case normal
        case destructive
    }

    internal var contentView: UIView?

    public var buttonStyle: ButtonType = .normal {
        didSet {
            setupUI()
        }
    }

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
        switch buttonStyle {
        case .normal:
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .appGreen
        case .destructive:
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .appRed
        }

        button.setupTouchEventsHandler()
    }
}
