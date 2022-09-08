//
//  ListViewController.swift
//  SatoshiWallet
//
//  Created by Pedro Gabriel on 07/09/22.
//

import UIKit

final class ListViewController: BaseViewController {
    // MARK: Properties
    private let viewModel: ListViewModel

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: Overrides
    init(viewModel: ListViewModel = .init()) {
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
        viewModel.getAssetLists()
    }

    // MARK: Methods
    private func setupUI() {
        title = "Satoshi Wallet"

        tableView.dataSource = self
        tableView.delegate = self

        let nib = UINib(nibName: ListTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ListTableViewCell.identifier)
        tableView.rowHeight = ListTableViewCell.rowHeight
    }

    private func bindEvents() {
        viewModel.handleSuccess = { [weak self] in
            self?.tableView.reloadData()
        }

        viewModel.handleError = { [weak self] _ in
            self?.showNetworkError {
                self?.viewModel.getAssetLists()
            }
        }

        viewModel.shouldProgressShow = { [weak self] isShowing in
            isShowing ? self?.showProgress() : self?.dismissProgress()
        }
    }

    private func navigateToDetails(with asset: Asset) {
        let viewController = DetailsViewController(viewModel: .init(asset: asset))
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: Extensions
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.assets?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ListTableViewCell.identifier) as? ListTableViewCell,
              let asset = viewModel.assets?[indexPath.row] else {

            return .init(frame: .zero)
        }

        cell.configure(with: asset)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let asset = viewModel.assets?[indexPath.row] else { return }
        navigateToDetails(with: asset)
    }
}
