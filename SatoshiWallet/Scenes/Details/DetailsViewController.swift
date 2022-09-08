//
//  DetailsViewController.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 08/09/22.
//

import UIKit

final class DetailsViewModel {
    // MARK: Properties
    var asset: Asset

    init(asset: Asset) {
        self.asset = asset
    }
}

final class DetailsViewController: UIViewController {
    // MARK: Properties
    let viewModel: DetailsViewModel

    // MARK: Overrides
    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
