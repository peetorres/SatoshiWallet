//
//  ListTableViewCell.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 08/09/22.
//

import UIKit
import Kingfisher

final class ListTableViewCell: UITableViewCell {
    // MARK: Constants
    private enum Constants {
        static let alphaOut: CGFloat = 0.4
    }

    // MARK: Properties
    static var identifier = "ListTableViewCell"
    static var rowHeight: CGFloat = 90

    // MARK: Outlets
    @IBOutlet weak var assetImageView: UIImageView!
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var marketCapLabel: UILabel!

    // MARK: Overrides
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: Public Methods
    func configure(with asset: Asset) {
        assetImageView.kf.setImage(with: imageUrl(of: asset))
        rankingLabel.text = asset.rank
        symbolLabel.text = asset.symbol
        nameLabel.text = asset.name
        priceLabel.text = asset.priceUsd?.currencyFormatting()
        marketCapLabel.text = asset.marketCapUsd?.currencyFormatting()

        animateLabelsUpdate()
    }

    private func animateLabelsUpdate() {
        priceLabel.alpha = Constants.alphaOut
        priceLabel.fadeIn()
        marketCapLabel.alpha = Constants.alphaOut
        marketCapLabel.fadeIn()
    }

    // MARK: Private Methods
    private func setupConstraints() {}

    private func imageUrl(of asset: Asset) -> URL? {
        let symbol = asset.symbol.lowercased()
        return URL(string: "https://assets.coincap.io/assets/icons/\(symbol)@2x.png")
    }
}
