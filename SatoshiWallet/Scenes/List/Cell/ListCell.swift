//
//  ListCell.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 08/09/22.
//

import UIKit
import Kingfisher

final class ListCell: UITableViewCell {
    // MARK: Constants
    private enum Constants {
        static let alphaOut: CGFloat = 0.4
    }

    // MARK: Properties
    static var identifier = "ListCell"
    static var rowHeight: CGFloat = 90

    // MARK: Outlets
    @IBOutlet weak var assetImageView: UIImageView!
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var variationLabel: UILabel!

    // MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: Public Methods
    func configure(with crypto: Crypto, shouldAnimateLabels: Bool) {
        let viewModel = ListCellViewModel(crypto: crypto)

        assetImageView.kf.setImage(with: viewModel.imageUrl())
        rankingLabel.text = viewModel.rank()
        symbolLabel.text = viewModel.symbol()
        nameLabel.text = viewModel.name()
        priceLabel.text = viewModel.price()
        variationLabel.text = viewModel.variation()
        variationLabel.textColor = viewModel.isChangePercentPositive() ? .appGreen : .appRed

        if shouldAnimateLabels {
            animateLabelsUpdate()
        }
    }

    // MARK: Private Methods
    private func animateLabelsUpdate() {
        priceLabel.alpha = Constants.alphaOut
        priceLabel.fadeIn()
        variationLabel.alpha = Constants.alphaOut
        variationLabel.fadeIn()
    }
}
