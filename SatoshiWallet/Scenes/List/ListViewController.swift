//
//  ListViewController.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 07/09/22.
//

import UIKit

final class ListViewController: UIViewController {
    // MARK: Properties
    private let viewModel: ListViewModel = .init()

    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindEvents()
    }

    // MARK: Methods
    private func setupUI() {
        title = "Satoshi Wallet"
    }

    private func bindEvents() {

    }
}
