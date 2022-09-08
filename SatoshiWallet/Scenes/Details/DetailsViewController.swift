//
//  DetailsViewController.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 08/09/22.
//

import UIKit

final class DetailsViewController: UIViewController {
    // MARK: Properties
    private let viewModel: DetailsViewModel

    // MARK: Outlets
    @IBOutlet weak var assetImageView: UIImageView!
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var variationLabel: UILabel!

    @IBOutlet weak var marketCapLabel: UILabel!
    @IBOutlet weak var volumeDayLabel: UILabel!
    @IBOutlet weak var maxSupplyLabel: UILabel!
    @IBOutlet weak var circulatingSupplyLabel: UILabel!
    @IBOutlet weak var explorerLabel: UILabel!

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
    }

    // MARK: Methods
    private func setupUI() {
        assetImageView.kf.setImage(with: viewModel.imageUrl())
        rankingLabel.text = viewModel.rankText()
        symbolLabel.text = viewModel.symbolText()
        nameLabel.text = viewModel.nameText()
        priceLabel.text = viewModel.priceText()
        variationLabel.text = viewModel.variationText()
        variationLabel.textColor = viewModel.isChangePercentPositive() ? .green : .red

        marketCapLabel.text = viewModel.marketcapText()
        volumeDayLabel.text = viewModel.volumeDayText()
        maxSupplyLabel.text = viewModel.maxSupplyText()
        circulatingSupplyLabel.text = viewModel.circulatingSupplyText()
        explorerLabel.text = viewModel.explorerText()
    }
}
