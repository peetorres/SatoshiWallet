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
    @IBOutlet private weak var buttonTryAgain: UIButton!

    // MARK: Actions
    @IBAction func pressedTryAgain(_ sender: Any) {
        pressedTryAgain?()
    }

    // MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLottie()
    }

    // MARK: Methods
    private func setupLottie() {
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 1
        animationView.play()
    }
}
