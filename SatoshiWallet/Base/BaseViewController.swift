//
//  BaseViewController.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 08/09/22.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: Properties
    private var progressView: ProgressView?
    private lazy var networkErrorView: NetworkErrorView = .fromNib()

    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: Basic Screens Views
extension BaseViewController {
    func showProgress() {
        progressView = .fromNib()
        guard let progressView = progressView else { return }
        view.addSubview(progressView)
        progressView.frame = view.bounds
    }

    func dismissProgress() {
        progressView?.removeFromSuperview()
        progressView = nil
    }

    func showNetworkError(didRetry: @escaping (() -> Void)) {
        networkErrorView.pressedTryAgain = { [weak self] in
            didRetry()
            self?.networkErrorView.removeFromSuperview()
        }
        view.addSubview(networkErrorView)
        networkErrorView.frame = view.bounds
    }
}
