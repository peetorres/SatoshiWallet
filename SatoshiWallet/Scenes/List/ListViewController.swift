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

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!


    // MARK: Overrides
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
    }

    private func bindEvents() {
        viewModel.handleSuccess = { [weak self] in
            print("success!")
            self?.tableView.reloadData()
        }

        viewModel.handleError = { _ in
            print("error")
        }

        viewModel.shouldProgressShow = { _ in
            print("showing progress")
        }
    }
}

// MARK: Extensions
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.assets?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")

        cell.textLabel?.text = viewModel.assets?[indexPath.row].symbol

        return cell
    }
}
