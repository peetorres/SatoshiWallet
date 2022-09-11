//
//  NetworkErrorView.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 08/09/22.
//

import UIKit
import Lottie

final class NetworkErrorView: UIView {
    // MARK: Properties
    public var pressedTryAgain: (() -> Void)?

    // MARK: Outlets
    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var tryAgainButton: PrimaryButton!

    // MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        bindEvents()
        setupLottie()
    }

    // MARK: Methods
    private func bindEvents() {
        tryAgainButton.handlerButton = { [weak self] in
            self?.pressedTryAgain?()
        }
    }

    private func setupLottie() {
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        animationView.play()
    }
}
