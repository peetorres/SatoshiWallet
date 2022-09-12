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
    var handleSelection: ((Crypto) -> Void)?

    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewBackgroundFetchError: UIView!

    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for Crypto"
        searchController.hidesNavigationBarDuringPresentation = false
        return searchController
    }()

    // MARK: Actions
    @objc
    func switchDidChange(sender: UISwitch!) {
        let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
        keyWindow?.overrideUserInterfaceStyle = sender.isOn ? .dark : .light
    }

    // MARK: Initializers
    deinit {
        self.viewModel.stopServerCryptoList()
    }

    init(viewModel: ListViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        return nil
    }

    // MARK: Overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindEvents()
        viewModel.getCryptoList(isBackgroundFetch: false)
    }

    // MARK: Methods
    private func setupUI() {
        viewBackgroundFetchError.isHidden = true
        setupTableView()
        setupNavigationBar()
    }

    private func bindEvents() {
        viewModel.handleSuccess = { [weak self] in
            self?.tableView.reloadData()
            self?.viewBackgroundFetchError.isHidden = true
        }

        viewModel.handleError = { [weak self] isBackgroundFetch, _ in
            if isBackgroundFetch {
                self?.viewBackgroundFetchError.isHidden = false
            } else {
                self?.showNetworkError {
                    self?.viewModel.getCryptoList(isBackgroundFetch: isBackgroundFetch)
                }
            }
        }

        viewModel.shouldReloadData = { [weak self] in
            self?.tableView.reloadData()
        }

        viewModel.shouldProgressShow = { [weak self] isShowing in
            isShowing ? self?.showProgress() : self?.dismissProgress()
        }
    }

    private func setupTableView() {
        let nib = UINib(nibName: ListCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: ListCell.identifier)

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = ListCell.rowHeight
    }

    private func setupNavigationBar() {
        title = "Satoshi Wallet"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.prefersLargeTitles = false
        setupNavigationBarSwitch()
    }

    private func setupNavigationBarSwitch() {
        let switchControl = UISwitch()
        let isDarkMode = traitCollection.userInterfaceStyle != .light
        switchControl.setOn(isDarkMode, animated: false)
        switchControl.addTarget(self, action: #selector(switchDidChange(sender:)), for: .valueChanged)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: switchControl)
    }

    private func search(for text: String) {
        viewModel.searchText = text
    }
}

// MARK: Extensions
extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.mutableCryptos?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ListCell.identifier) as? ListCell,
              let crypto = viewModel.mutableCryptos?[indexPath.row] else {
            return .init(frame: .zero)
        }

        let shouldAnimateLabels = searchController.isActive == false
        cell.configure(with: crypto, shouldAnimateLabels: shouldAnimateLabels)

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let crypto = viewModel.mutableCryptos?[indexPath.row] else { return }
        handleSelection?(crypto)
    }
}

extension ListViewController: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        search(for: searchText)
    }
}
