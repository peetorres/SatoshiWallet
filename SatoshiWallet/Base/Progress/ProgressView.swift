//
//  ProgressView.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 08/09/22.
//

import UIKit
import Lottie

final class ProgressView: UIView {
    // MARK: Outlets
    @IBOutlet weak var animationView: AnimationView!

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
