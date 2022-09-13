//
//  UIButton+Extensions.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 11/09/22.
//

import UIKit

extension UIButton {
    private enum ButtonState {
        case highlighted
        case normal

        var alpha: CGFloat {
            return self == .normal ? 1 : 0.4
        }
    }

    public func setupTouchEventsHandler() {
        self.addTarget(self, action: #selector(touchUpInsideEvent), for: .touchUpInside)
        self.addTarget(self, action: #selector(touchDownEventAction), for: .touchDown)
    }

    // MARK: Transform at events
    private func perform(state: ButtonState) {
        let scale: CGFloat = state == .normal ? 1 : 0.9
        UIView.animate(
            withDuration: 0.1,
            delay: 0,
            options: .curveEaseInOut,
            animations: { [weak self] in
                self?.transform = CGAffineTransform.identity.scaledBy(x: scale, y: scale)
            })
    }

    @objc
    private func touchDownEventAction() {
        self.perform(state: .highlighted)
    }

    @objc
    private func touchUpInsideEvent() {
        self.perform(state: .normal)
    }
}
