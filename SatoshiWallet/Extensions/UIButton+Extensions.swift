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
        self.addTarget(self, action: #selector(touchDragInsideEventAction), for: .touchDragInside)
        self.addTarget(self, action: #selector(touchUpOutsideEvent), for: .touchDragOutside)
        self.addTarget(self, action: #selector(touchUpOutsideEvent), for: .touchCancel)
        self.addTarget(self, action: #selector(touchUpOutsideEvent), for: .touchDragExit)
    }

    // MARK: - Transform at events

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
    private func touchDragInsideEventAction() {
        self.perform(state: .highlighted)
    }

    @objc
    private func touchUpInsideEvent() {
        self.perform(state: .normal)
    }

    @objc
    private func touchUpOutsideEvent() {
        self.perform(state: .normal)
    }

    func addLeftImage(image: UIImage, offset: CGFloat) {
        setImage(image, for: .normal)
        imageView?.translatesAutoresizingMaskIntoConstraints = false
        imageView?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView?.leadingAnchor.constraint(equalTo: leadingAnchor, constant: offset).isActive = true
    }

    func changeButtonAnimated(image: UIImage?) {
        guard let imageView = self.imageView, let currentImage = imageView.image, let newImage = image else {
            return
        }
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.setImage(newImage, for: UIControl.State.normal)
        }
        let crossFade: CABasicAnimation = CABasicAnimation(keyPath: "contents")
        crossFade.duration = 0.3
        crossFade.fromValue = currentImage.cgImage
        crossFade.toValue = newImage.cgImage
        crossFade.isRemovedOnCompletion = false
        crossFade.fillMode = CAMediaTimingFillMode.forwards
        imageView.layer.add(crossFade, forKey: "animateContents")
        CATransaction.commit()
    }
}
