//
//  ListTableViewCell.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 08/09/22.
//

import UIKit

final class ListTableViewCell: UITableViewCell {
    static var identifier = "ListTableViewCell"

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
        rankingLabel.text = asset.rank
        symbolLabel.text = asset.symbol
        nameLabel.text = asset.name
        priceLabel.text = asset.priceUsd
        marketCapLabel.text = asset.marketCapUsd
    }

    // MARK: Private Methods
    private func setupConstraints() {

    }
}
