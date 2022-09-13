//
//  DetailsViewController.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 08/09/22.
//

import UIKit

final class DetailsViewController: UIViewController {
    // MARK: Properties
    let viewModel: DetailsViewModel
    var explorerPressed: ((String) -> Void)?
    var learnMorePressed: ((String) -> Void)?

    // MARK: Outlets
    @IBOutlet weak var assetImageView: UIImageView!
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var variationLabel: UILabel!

    @IBOutlet weak var maxSupplyLabel: UILabel!
    @IBOutlet weak var circulatingSupplyLabel: UILabel!
    @IBOutlet weak var explorerLabel: UILabel!

    @IBOutlet weak var explorerButton: PrimaryButton!
    @IBOutlet weak var learnMoreButton: SecondaryButton!

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
        setupUI()
        bindEvents()
    }

    // MARK: Methods
    private func setupUI() {
        title = viewModel.name()

        assetImageView.kf.setImage(with: viewModel.imageUrl())
        rankingLabel.text = viewModel.rank()
        symbolLabel.text = viewModel.symbol()
        nameLabel.text = viewModel.name()
        priceLabel.text = viewModel.price()
        variationLabel.text = viewModel.variation()
        variationLabel.textColor = viewModel.isChangePercentPositive() ? .appGreen : .appRed

        maxSupplyLabel.text = viewModel.maxSupply()
        circulatingSupplyLabel.text = viewModel.circulatingSupply()
        explorerLabel.text = viewModel.explorer()
    }

    func bindEvents() {
        explorerButton.handlerButton = { [weak self] in
            self?.explorerPressed?("Do some exploration!")
        }

        learnMoreButton.handlerButton = { [weak self] in
            self?.learnMorePressed?("Have a good learn!")
        }
    }
}
